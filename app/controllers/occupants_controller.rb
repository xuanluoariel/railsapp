class OccupantsController < ApplicationController
  before_action :find_space_category

  # GET /occupants
  # GET /occupants.json
  def index
    @occupants = @space_category.occupants
  end

  # GET /occupants/1
  # GET /occupants/1.json
  def show
    @occupant = @space_category.occupants.find( params[:id] )
  end

  # GET /occupants/new
  def new
    @occupant = @space_category.occupants.build
  end

  # GET /occupants/1/edit
  def edit
    @occupant = @space_category.occupants.find( params[:id] )
  end

  # POST /occupants
  # POST /occupants.json
  def create
    @occupant = @space_category.occupants.new(occupant_params)

    respond_to do |format|
      if @occupant.save
        format.html { redirect_to edit_basic_space_category_path(@basic, @space_category), notice: 'Occupant was successfully created.' }
        format.json { render :show, status: :created, location: @occupant }
      else
        format.html { render :new }
        format.json { render json: @occupant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /occupants/1
  # PATCH/PUT /occupants/1.json
  def update
    @occupant = @space_category.occupants.find( params[:id] )
    respond_to do |format|
      if @occupant.update(occupant_params)
        format.html { redirect_to edit_basic_space_category_path(@basic, @space_category), notice: 'Occupant was successfully updated.' }
        format.json { render :show, status: :ok, location: @occupant }
      else
        format.html { render :edit }
        format.json { render json: @occupant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occupants/1
  # DELETE /occupants/1.json
  def destroy
    @occupant = @space_category.occupants.find( params[:id] )
    @occupant.destroy
    respond_to do |format|
      format.html { redirect_to edit_basic_space_category_path(@basic, @space_category), notice: 'Occupant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_space_category
      @basic = Basic.find(params[:basic_id])
      @space_category = SpaceCategory.find(params[:space_category_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def occupant_params
      params.require(:occupant).permit(:occupantType, :percentage, :space_category_id)
    end
end
