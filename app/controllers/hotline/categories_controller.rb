class Hotline::CategoriesController < ApplicationController
  before_action :set_hotline_category, only: [:show, :edit, :update, :destroy]

  # GET /hotline/categories
  # GET /hotline/categories.json
  def index
    @hotline_categories = Hotline::Category.all
  end

  # GET /hotline/categories/1
  # GET /hotline/categories/1.json
  def show
  end

  # GET /hotline/categories/new
  def new
    @hotline_category = Hotline::Category.new
  end

  # GET /hotline/categories/1/edit
  def edit
  end

  # POST /hotline/categories
  # POST /hotline/categories.json
  def create
    @hotline_category = Hotline::Category.new(hotline_category_params)

    respond_to do |format|
      if @hotline_category.save
        format.html { redirect_to @hotline_category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @hotline_category }
      else
        format.html { render :new }
        format.json { render json: @hotline_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotline/categories/1
  # PATCH/PUT /hotline/categories/1.json
  def update
    respond_to do |format|
      if @hotline_category.update(hotline_category_params)
        format.html { redirect_to @hotline_category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotline_category }
      else
        format.html { render :edit }
        format.json { render json: @hotline_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotline/categories/1
  # DELETE /hotline/categories/1.json
  def destroy
    @hotline_category.destroy
    respond_to do |format|
      format.html { redirect_to hotline_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotline_category
      @hotline_category = Hotline::Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotline_category_params
      params.require(:hotline_category).permit(:href, :name, :parent_id)
    end
end
