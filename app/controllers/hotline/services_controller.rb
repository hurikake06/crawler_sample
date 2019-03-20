class Hotline::ServicesController < ApplicationController
  before_action :set_hotline_service, only: [:show, :edit, :update, :destroy]

  # GET /hotline/services
  # GET /hotline/services.json
  def index
    @hotline_services = Hotline::Service.all
  end

  # GET /hotline/services/1
  # GET /hotline/services/1.json
  def show
  end

  # GET /hotline/services/new
  def new
    @hotline_service = Hotline::Service.new
  end

  # GET /hotline/services/1/edit
  def edit
  end

  # POST /hotline/services
  # POST /hotline/services.json
  def create
    @hotline_service = Hotline::Service.new(hotline_service_params)

    respond_to do |format|
      if @hotline_service.save
        format.html { redirect_to @hotline_service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @hotline_service }
      else
        format.html { render :new }
        format.json { render json: @hotline_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotline/services/1
  # PATCH/PUT /hotline/services/1.json
  def update
    respond_to do |format|
      if @hotline_service.update(hotline_service_params)
        format.html { redirect_to @hotline_service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotline_service }
      else
        format.html { render :edit }
        format.json { render json: @hotline_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotline/services/1
  # DELETE /hotline/services/1.json
  def destroy
    @hotline_service.destroy
    respond_to do |format|
      format.html { redirect_to hotline_services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotline_service
      @hotline_service = Hotline::Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotline_service_params
      params.require(:hotline_service).permit(:href, :category_id, :value)
    end
end
