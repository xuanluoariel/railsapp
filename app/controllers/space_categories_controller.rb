class SpaceCategoriesController < ApplicationController
  before_action :find_basic

  # GET /space_categories
  # GET /space_categories.json
  def index
    @space_categories = @basic.space_categories
  end

  # GET /space_categories/1
  # GET /space_categories/1.json
  def show
    @space_category = @basic.space_categories.find( params[:id] )
  end

  # GET /space_categories/new
  def new
    @space_category = @basic.space_categories.build
  end

  # GET /space_categories/1/edit
  def edit
    @space_category = @basic.space_categories.find( params[:id] )
  end

  # POST /space_categories
  # POST /space_categories.json
  def create
    @space_category = @basic.space_categories.new(space_category_params)

    respond_to do |format|
      if @space_category.save
        format.html { redirect_to edit_basic_space_category_path(@basic, @space_category), notice: 'Space category was successfully created.' }
        format.json { render :show, status: :created, location: @space_category }
      else
        format.html { render :new }
        format.json { render json: @space_category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_space_category
    @space_category = @basic.space_categories.find(params[:id])
    @space_category.name = params["space_category_name#{@space_category.id}"]
    @space_category.density = params["space_category_density#{@space_category.id}"]
    @space_category.save
    respond_to do |format|
      format.html {  render :action=>:edit }
    end
  end
  
  def update_occupant
    @space_category = @basic.space_categories.find(params[:id])
    @space_category.occupants.each do |o|
      o.occupantType = params["occupant_occupantType#{o.id}"]
      o.percentage = params["occupant_percentage#{o.id}"]
      if not o.save
        o.errors.each do |attr, msg|
          @space_category.errors["Occupant #{o.id}: #{attr}"]= msg
        end
      end
    end

    if params[:commit] == "Add occupant group"
      occupant = Occupant.new
      occupant.space_category = @space_category

      occupant.occupantType = ""
      occupant.percentage = 0
      if not occupant.save
        occupant.errors.each do |attr, msg|
          @space_category.errors["Occupant #{occupant.id}: #{attr}"]= msg
        end
      end
      @space_category.occupants.push(occupant)
      @space_category.save
    end

    respond_to do |format|
      format.html {  render :action=>:edit }
    end
  end
  
  # PATCH/PUT /space_categories/1
  # PATCH/PUT /space_categories/1.json
  def update
    @space_category = @basic.space_categories.find(params[:id])
    respond_to do |format|
      if @space_category.update(space_category_params)
        format.html { redirect_to edit_basic_path(@basic), notice: 'Space category was successfully updated.' }
        format.json { render :show, status: :ok, location: @space_category }
      else
        format.html { render :edit }
        format.json { render json: @space_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /space_categories/1
  # DELETE /space_categories/1.json
  def destroy
    @space_category = @basic.space_categories.find(params[:id])
    @space_category.destroy
    respond_to do |format|
      format.html { redirect_to basic_space_categories_path(@basic), notice: 'Space category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_basic
      @basic = Basic.find(params[:basic_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_category_params
      params.require(:space_category).permit(:name, :area, :density, :basic_id)
    end
end
