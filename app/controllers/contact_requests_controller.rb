class ContactRequestsController < ApplicationController
  before_action :set_contact_request, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  # GET /contact_requests
  def index
    @contact_requests = ContactRequest.all
  end

  # GET /contact_requests/1
  def show
  end

  # GET /contact_requests/new
  def new
    @contact_request = ContactRequest.new
  end

  # GET /contact_requests/1/edit
  def edit
  end

  # POST /contact_requests
  def create
    @contact_request = ContactRequest.new(contact_request_params)

    if @contact_request.save
      redirect_to @contact_request, notice: 'Contact request was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /contact_requests/1
  def update
    if @contact_request.update(contact_request_params)
      redirect_to @contact_request, notice: 'Contact request was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /contact_requests/1
  def destroy
    @contact_request.destroy
    redirect_to contact_requests_url, notice: 'Contact request was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_request
      @contact_request = ContactRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_request_params
      params.require(:contact_request).permit(:email, :zipcode)
    end
end
