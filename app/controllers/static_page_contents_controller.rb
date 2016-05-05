class StaticPageContentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_static_page_content, only: [:show, :edit, :update, :destroy]

  # GET /static_page_contents
  def index
    @static_page_contents = StaticPageContent.all
  end

  # GET /static_page_contents/1
  def show
  end

  # GET /static_page_contents/new
  def new
    @static_page_content = StaticPageContent.new
  end

  # GET /static_page_contents/1/edit
  def edit
  end

  # POST /static_page_contents
  def create
    @static_page_content = StaticPageContent.new(static_page_content_params)

    if @static_page_content.save
      redirect_to @static_page_content, notice: 'Static page content was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /static_page_contents/1
  def update
    if @static_page_content.update(static_page_content_params)
      redirect_to @static_page_content, notice: 'Static page content was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /static_page_contents/1
  def destroy
    @static_page_content.destroy
    redirect_to static_page_contents_url, notice: 'Static page content was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_static_page_content
      @static_page_content = StaticPageContent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def static_page_content_params
      params.require(:static_page_content).permit(:key, :value, :bootsy_image_gallery_id)
    end
end
