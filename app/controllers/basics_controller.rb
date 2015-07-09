class BasicsController < ApplicationController
  before_action :set_basic

  # GET /basics/1/edit
  def edit
  end
  
  def update_zone
    @basic.spaces.each do |s|
      s.name = params["space_name#{s.id}"]
      s.spaceType = params["space_spaceType#{s.id}"]
      s.multiplier = params["space_multiplier#{s.id}"]
      s.area = params["space_area#{s.id}"]
      if not s.save
        s.errors.each do |attr, msg|
          @basic.errors["Space #{s.id}: #{attr}"]= msg
        end
      end
    end

    if params[:commit] == "Add new zone"
      space = Space.new
      space.basic = @basic
      number = 0
      while true
        s = Space.find_by_name("Zone #{number+1}")
        if s == nil
          break
        else
          number += 1 
        end
      end
      space.name = "Zone #{number+1}"
      space.spaceType = "Office"
      space.multiplier = 1
      space.area = 10
      if not space.save
        space.errors.each do |attr, msg|
          @basic.errors["Space #{space.id}: #{attr}"]= msg
        end
      end
      @basic.spaces.push(space)
      @basic.save
    end

    respond_to do |format|
      format.html {  render :action=>:edit }
    end
  end

  # POST /basics
  def create
    @basic = Basic.new(basic_params)
    respond_to do |format|
      if @basic.save
        format.html { redirect_to edit_basic_path(@basic), notice: 'Basic was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basic
      @basic = Basic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def basic_params
      params.require(:basic).permit(:buildingType, :buildingId)
    end
end
