class ChildrenController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, except: [:show, :curated]

  # GET /users/:user_id/children/new
  def new
    @child = @user.children.build
    @questions = (Question.left_brain.sample(5) + Question.right_brain.sample(5)).sample(10)
  end

  # POST /users/:user_id/children
  def create
    @child = @user.children.build(child_params)

    if @child.save
      render json: { success: true, child_id: @child.id }
    else
      render json: { error: true, message: "Please complete all the details." }
    end
  end

  # GET /users/:user_id/children/:id/edit
  def edit
    @child = @user.children.find(params[:id])
  end

  # GET children/:id
  def show
    @child = current_user.children.find(params[:id])
    @subscription = @child.subscription
  end

  # PATCH/PUT /users/:user_id/children/:id
  def update
    @child = @user.children.find(params[:id])

    if @child.update(child_params)
      redirect_to current_user, notice: "#{@child.first_name} details updated."
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/children/:id
  def destroy
    @child = @user.children.find(params[:id])
    @child.destroy

    redirect_to current_user, notice: "#{@child.first_name} deleted."
  end

  # filters
  # - which partner
  # - which activity
  # - age, gender, zipcode
  # - curation schedules have equally points
  # - each element  (7) will have different points
  # - each element maximum 3 klass

  # Klass A - [A, B, C]
  # Klass B - [A, D, E]
  def curated
    @child = Child.find(params[:id])
    # current_user.children

    zipcode = Zipcode.find_by_pincode(current_user.location)

    if zipcode.present?
      city = zipcode.city

      # Sort the ages of children
      age = Time.now.year - @child.birth_year
      gender = @child.gender

      @klasses = Klass.non_archived_schedules
                      .includes(:activity, :schedules, :partner, :development_elements, klass_elements: [:development_element])
                      .where("klasses.age_end <= ? and klasses.city_id = ? and klasses.gender = ?", age, city.id, Child.genders[gender])

      # Get same amount of points based on all different 7 elements
      # Curated 15 Klass based on different development elements
      if @klasses.present?
        @klasses.each do |klass|
          klass.klass_elements.each do |element|
            if instance_variable_get("@#{element.development_element.title.downcase}_count").present?
              element_count = instance_variable_get("@#{element.development_element.title.downcase}_count")
              count = element_count + 1
              instance_variable_set("@#{element.development_element.title.downcase}_count",  count)
            else
              instance_variable_set("@#{element.development_element.title.downcase}_count", 1)
            end
          end
        end
      end
    else
      redirect_to schedules_path, notice: 'Browse through our latest schedules now!'
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def child_params
    params.require(:child).permit(:first_name, :last_name, :birth_year, :gender)
  end
end
