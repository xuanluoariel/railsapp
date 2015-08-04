class SpaceCategoriesController < ApplicationController
  before_action :find_basic
# 
  # def new
    # @space_category = @basic.space_categories.build
  # end
# 
  # def edit
    # @space_category = @basic.space_categories.find( params[:id] )
  # end

  def create_new
    @space_category = @basic.space_categories.new
    name = params[:name]
    @space_category.usage = params[:usage]
    session["Basic #{@basic.id} error"] = nil
    duplicated = false
    respond_to do |format|
      @basic.space_categories.each do |ss|
        if ss.name == name 
          duplicated = true
        end
      end
      if not duplicated
        @space_category.name = name
        @space_category.save
        format.html { redirect_to :controller => :space_categories, :action => :forms, :basic_id=> @basic.id, :s_id=>@space_category.id }
      else
        session["Basic #{@basic.id} error"] = "Name '#{name}' has been taken."
        @space_category.destroy
        @basic.save
        format.html { redirect_to :controller => :space_categories, :action => :index, :id=> @basic.id}
      end
    end
   
  end
  
  def update_space_category
    @space_category = @basic.space_categories.find(params[:s_id])
    @space_category.name = params["space_category_name#{@space_category.id}"]
    @space_category_error = Array.new
    if params["space_category_density#{@space_category.id}"] != nil
      @space_category.density = params["space_category_density#{@space_category.id}"]
    end
    if params["space_category_max_num#{@space_category.id}"] != nil
      @space_category.max_num = params["space_category_max_num#{@space_category.id}"]
    end
    if params["space_category_min_num#{@space_category.id}"] != nil
      @space_category.min_num = params["space_category_min_num#{@space_category.id}"]
    end
    @space_category.save
    redirect_to :controller => :space_categories, :action => :forms, :basic_id=> @basic.id, :s_id=> @space_category.id
  end
  
  def update_space_category_index
    @space_category = @basic.space_categories.find(params[:id])
    
    session["Space category #{@space_category.id} error"] = nil
    @space_category.usage = params["space_category_usage#{@space_category.id}"]
    
    duplicated = false
    name = params["space_category_name#{@space_category.id}"]
    if name != @space_category.name
      @basic.space_categories.each do |ss|
        if ss.name == name 
          duplicated = true
          break
        end
      end
      if not duplicated
        @space_category.name = name
      else
        session["Space category #{@space_category.id} error"]  = "Name has been taken."
      end
    end
    if params["space_category_density#{@space_category.id}"] != nil
      @space_category.density = params["space_category_density#{@space_category.id}"]
      if (not @space_category.density.is_a? Numeric) or (@space_category.density <= 0)
        session["Space category #{@space_category.id} error"]  = "Density must be a number greater than 0."
      end
    else
      @space_category.density = 150
    end
    
    if params["space_category_max_num#{@space_category.id}"] != nil
      @space_category.max_num = params["space_category_max_num#{@space_category.id}"]
      if (not @space_category.max_num.is_a? Numeric) or (@space_category.max_num <= 0)
        session["Space category #{@space_category.id} error"]  = "Maximum occupant number must be a number greater than 0."
      end
    else
      @space_category.max_num = 5
    end
    
    if params["space_category_min_num#{@space_category.id}"] != nil
      @space_category.min_num = params["space_category_min_num#{@space_category.id}"]
      if (not @space_category.min_num.is_a? Numeric) or (@space_category.min_num < 0)
        session["Space category #{@space_category.id} error"]  = "Minimum occupant number must be a number greater or equal to 0."
      end
    else
      @space_category.min_num = 0
    end
    
    if session["Space category #{@space_category.id} error"] == nil
      @space_category.save
    end
    redirect_to :controller => :space_categories, :action => :index, :id=> @basic.id
  end 
   
  def update_occupant
    @space_category = @basic.space_categories.find(params[:s_id])
    session["Space category #{@space_category.id} error"]  = nil
    @space_category.occupants.each_with_index do |o, index|
      o.occupantType = params["occupant_occupantType#{o.id}"]
      o.percentage = params["occupant_percentage#{o.id}"]
      if index == @space_category.occupants.length-1
        perc = 0
        @space_category.occupants.each_with_index do |occ, ind|
          if ind < @space_category.occupants.length-1
            perc += occ.percentage
          end
        end
        o.percentage = 100 - perc
        if o.percentage < 0
          o.percentage = 0
          session["Space category #{@space_category.id} error"]  = "Total percentage should be 100."
        end
      end
      o.save
    end
    if params[:commit] == "Add occupant group"
      occupant = Occupant.new
      occupant.space_category = @space_category
      occupant.occupantType = @basic.occupant_categories.first.name
      perc = 0
      @space_category.occupants.each_with_index do |occ, ind|
        if ind < @space_category.occupants.length
          perc += occ.percentage
        end
      end
      occupant.percentage = 100 - perc
      occupant.save
      @space_category.occupants.push(occupant)
      @space_category.save
    end
    respond_to do |format|
      format.html { redirect_to :controller => :space_categories, :action => :forms, :basic_id=> @basic.id, :s_id=> @space_category.id }
    end
  end
  
  def update_occupant_index
    @space_category = @basic.space_categories.find(params[:id])
    @space_category.occupants.each_with_index do |o, index|
      o.occupantType = params["occupant_occupantType#{o.id}"]
      o.percentage = params["occupant_percentage#{o.id}"]
      if index == @space_category.occupants.length-1
        perc = 0
        @space_category.occupants.each_with_index do |occ, ind|
          if ind < @space_category.occupants.length-1
            perc += occ.percentage
          end
        end
        o.percentage = 100 - perc
        if o.percentage < 0
          o.percentage = 0
          session["Space category #{@space_category.id} error"]  = "Total percentage should be 100."
        end
      end
      o.save
    end
    if params[:commit] == "Add occupant group"
      occupant = Occupant.new
      occupant.space_category = @space_category
      occupant.occupantType = @basic.occupant_categories.first.name
      perc = 0
      @space_category.occupants.each_with_index do |occ, ind|
        if ind < @space_category.occupants.length
          perc += occ.percentage
        end
      end
      occupant.percentage = 100 - perc
      occupant.save
      @space_category.occupants.push(occupant)
      @space_category.save
    end
    respond_to do |format|
      format.html { redirect_to :controller => :space_categories, :action => :index, :basic_id=> @basic.id }
    end
  end
  
  def check_percent
    @space_category = @basic.space_categories.find(params[:s_id])
    @space_category_error = Array.new
    @basic.space_categories.each do |ss|
      if (ss.id < @space_category.id) and (ss.name == @space_category.name)
        @space_category_error.push("Name '#{@space_category.name}' has been taken.")
        
      end
    end
    if @space_category.usage == "Office"
      if (not @space_category.density.is_a? Numeric) or (@space_category.density <= 0)
        @space_category_error.push("Density should be a number greater than 0.")
      end
      percent = 0
      @space_category.occupants.each do |o|
        percent += o.percentage 
      end
      if (percent != 100)
        @space_category_error.push("Total percentage should be 100%.")
      end
    else
      if (not @space_category.max_num.is_a? Numeric) or (@space_category.max_num <= 0)
        @space_category_error.push("Maximum occupant number should be a number greater 0.")
      end
      if (not @space_category.min_num.is_a? Numeric) or (@space_category.min_num < 0)
        @space_category_error.push("Minimum occupant number should be a number greater or equal to 0.")
      end 
      if @space_category.min_num.is_a? Numeric and @space_category.min_num.is_a? Numeric and @space_category.min_num >=@space_category.max_num
        @space_category_error.push("Maximum occupant number should be greater than minimum occupant number.")
      end
    end
    respond_to do |format|
      if @space_category_error.length == 0
        format.html { redirect_to :controller => :space_categories, :action => :index, :id=> @basic.id }
      else
        format.html { render :action=>:forms }
      end
    end
  end
  
  def cancel_add
    @space_category = @basic.space_categories.find(params[:s_id])
    @space_category.destroy
    respond_to do |format|
      format.html { render :index}
    end
  end
  
  def update_meeting
    @space_category = @basic.space_categories.find(params[:s_id])
    @space_category.meetings.each do |m|
      m.duration = params["meeting_duration#{m.id}"]
      m.time_range = params["meeting_time_range#{m.id}"]
      
      case m.time_range
        when "Morning (9am-12pm)"
          m.start_time = "09:00"
          m.end_time = "12:00"
        when "Noon (12pm-2pm)"
          m.start_time = "12:00"
          m.end_time = "14:00"
        when "Afternoon (2pm-6pm)"
          m.start_time = "14:00"
          m.end_time = "18:00"
        when "Evening (6pm-9pm)"
          m.start_time = "18:00"
          m.end_time = "21:00"
        else
          m.start_time = "09:00"
          m.end_time = "18:00"
      end
      m.prob = params["meeting_prob#{m.id}"]
      if not m.save
        m.errors.each do |attr, msg|
          @space_category.errors["Meeting #{m.id}: #{attr}"]= msg
        end
      end
    end
    if params[:commit] == "Add meeting"
      meeting = Meeting.new
      meeting.space_category = @space_category
      meeting.duration = 60
      meeting.time_range = "Morning (9am-12pm)"
      meeting.start_time = "9:00"
      meeting.end_time = "12:00"
      meeting.prob = 80
      if not meeting.save
        meeting.errors.each do |attr, msg|
          @space_category.errors["Meeting #{meeting.id}: #{attr}"]= msg
        end
      end
      @space_category.meetings.push(meeting)
      @space_category.save
    end
    respond_to do |format|
      format.html { redirect_to :controller => :space_categories, :action => :forms, :basic_id=> @basic.id, :s_id=> @space_category.id }
    end
  end
  
  def update_meeting_index
    @space_category = @basic.space_categories.find(params[:id])
    @space_category.meetings.each do |m|
      m.duration = params["meeting_duration#{m.id}"]
      m.time_range = params["meeting_time_range#{m.id}"]
      
      case m.time_range
        when "Morning (9am-12pm)"
          m.start_time = "09:00"
          m.end_time = "12:00"
        when "Noon (12pm-2pm)"
          m.start_time = "12:00"
          m.end_time = "14:00"
        when "Afternoon (2pm-6pm)"
          m.start_time = "14:00"
          m.end_time = "18:00"
        when "Evening (6pm-9pm)"
          m.start_time = "18:00"
          m.end_time = "21:00"
        else
          m.start_time = "09:00"
          m.end_time = "18:00"
      end
      m.prob = params["meeting_prob#{m.id}"]
      if not m.save
        m.errors.each do |attr, msg|
          @space_category.errors["Meeting #{m.id}: #{attr}"]= msg
        end
      end
    end
    if params[:commit] == "Add meeting"
      meeting = Meeting.new
      meeting.space_category = @space_category
      meeting.duration = 60
      meeting.time_range = "Morning (9am-12pm)"
      meeting.start_time = "9:00"
      meeting.end_time = "12:00"
      meeting.prob = 80
      if not meeting.save
        meeting.errors.each do |attr, msg|
          @space_category.errors["Meeting #{meeting.id}: #{attr}"]= msg
        end
      end
      @space_category.meetings.push(meeting)
      @space_category.save
    end
    respond_to do |format|
      format.html {  redirect_to :controller => :space_categories, :action => :index, :basic_id=> @basic.id}
    end
  end
  
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
end
