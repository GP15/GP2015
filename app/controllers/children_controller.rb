class ChildrenController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user

  # GET /users/:user_id/children/new
  def new
    @child = @user.children.build
  end

  # POST /users/:user_id/children
  def create
    @child = @user.children.build(child_params)

    if @child.save
      redirect_to current_user, notice: "#{@child.first_name} added to children list."
    else
      render :new
    end
  end

  # GET /users/:user_id/children/:id/edit
  def edit
    @child = @user.children.find(params[:id])
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

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def child_params
      params.require(:child).permit(:first_name, :last_name, :birth_year)
    end
end
