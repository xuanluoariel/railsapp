class SpacesController < ApplicationController
  before_action :find_basic

  
  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space = @basic.spaces.find(params[:id])
    @space.destroy
    respond_to do |format|
      format.html { redirect_to edit_basic_path(@basic), notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
    puts "before"
    Space.import(params[:file])
    redirect_to spaces_path, notice:"Sucess!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_basic
      @basic = Basic.find(params[:basic_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:name, :spaceType, :multiplier, :area)
    end
end
