class MeetingsController < ApplicationController
  before_action :find_space_category
  def destroy
    @meeting = @space_category.meetings.find( params[:id] )
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to basic_space_categories_path(@basic), notice: 'Meeting was successfully destroyed.' }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def find_space_category
      @basic = Basic.find(params[:basic_id])
      @space_category = SpaceCategory.find(params[:space_category_id])
    end
end
