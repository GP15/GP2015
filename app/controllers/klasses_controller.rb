class KlassesController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def new
    @partner = Partner.find(params[:partner_id])
    @klass = @partner.klasses.build
  end

  def edit
    @partner = Partner.find(params[:partner_id])
    @klass   = @partner.klasses.find(params[:id])
  end

  def create
    @partner = Partner.find(params[:partner_id])
    @klass = @partner.klasses.build(klass_params)

    if @klass.save
      redirect_to admin_partner_path(@partner.id), notice: 'New class created.'
    else
      render :new
    end
  end

  def update
    @partner = Partner.find(params[:partner_id])
    @klass   = @partner.klasses.find(params[:id])

    if @klass.update(klass_params)
      @klass.schedules.update_all(activity_id: klass_params[:activity_id])
      redirect_to admin_partner_path(@partner.id), notice: 'Class updated.'
    else
      render :edit
    end
  end

  def destroy
    @partner = Partner.find(params[:partner_id])
    @klass   = @partner.klasses.find(params[:id])
    @klass.destroy

    redirect_to admin_partner_path(@partner.id), notice: 'Class deleted.'
  end

  private

    def klass_params
      params.require(:klass).permit(:name, :activity_id, :level,
                                    :age_start, :age_end, :description)
    end
end
