class OccupantCategoriesController < ApplicationController
  before_action :find_basic

  # GET /occupant_categories
  # GET /occupant_categories.json
  def index
    @occupant_categories = @basic.occupant_categories
  end

  # GET /occupant_categories/1
  # GET /occupant_categories/1.json
  def show
    @occupant_category = @basic.occupant_categories.find( params[:id] )
  end

  # GET /occupant_categories/new
  def new
    @occupant_category = @basic.occupant_categories.build
  end

  # GET /occupant_categories/1/edit
  def edit
    @occupant_category = @basic.occupant_categories.find( params[:id] )
  end

  # POST /occupant_categories
  # POST /occupant_categories.json
  def create
    @occupant_category = @basic.occupant_categories.new(occupant_category_params)

    respond_to do |format|
      if @occupant_category.save
        format.html { redirect_to edit_basic_path(@basic), notice: 'Occupant category was successfully created.' }
        format.json { render :show, status: :created, location: @occupant_category }
      else
        format.html { render :new }
        format.json { render json: @occupant_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /occupant_categories/1
  # PATCH/PUT /occupant_categories/1.json
  def update
    @occupant_category = @basic.occupant_categories.find(params[:basic_id])
    respond_to do |format|      
      if @occupant_category.update(occupant_category_params)
        format.html { redirect_to edit_basic_path(@basic), notice: 'Occupant category was successfully updated.' }
        format.json { render :show, status: :ok, location: @occupant_category }
      else
        format.html { render :edit }
        format.json { render json: @occupant_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occupant_categories/1
  # DELETE /occupant_categories/1.json
  def destroy
    @occupant_category = @basic.occupant_categories.find(params[:basic_id])
    @occupant_category.destroy
    respond_to do |format|
      format.html { redirect_to occupant_categories_url, notice: 'Occupant category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_basic
      @basic = Basic.find(params[:basic_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def occupant_category_params
      params.require(:occupant_category).permit(:name, :ATypical, :AStart, :AEnd, :WMTypical, :WMStart, :WMEnd, :GTLTypical, :GTLStart, :GTLEnd,
                                                :BFLTypical, :BFLStart, :BFLEnd, :WATypical, :WAStart, :WAEnd, :DTypical, :DStart, :DEnd,
                                                :ownPercent, :ownDuration, :otherPercent, :otherDuration, :auxPercent, :auxDuration, :meetingPercent, :meetingDuration, :outPercent, :outDuration)
    end
end
