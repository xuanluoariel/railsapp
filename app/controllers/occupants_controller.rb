class OccupantsController < ApplicationController
  before_action :find_space_category
  
  def destroy
    @occupant = @space_category.occupants.find( params[:id] )
    @occupant.destroy
    respond_to do |format|
      format.html { redirect_to basic_space_categories_path(@basic), notice: 'Occupant was successfully destroyed.' }
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
