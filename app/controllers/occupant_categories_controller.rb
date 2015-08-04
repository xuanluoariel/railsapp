class OccupantCategoriesController < ApplicationController
  before_action :find_basic
  def update_occupant_category_index
    @occupant_category = @basic.occupant_categories.find(params[:id])
    session["Occupant category #{@occupant_category.id} error"] = nil
    name = params[:name]
    duplicated = false
    if name != @occupant_category.name
      @basic.occupant_categories.each do |ss|
        if ss.name == name 
          duplicated = true
          break
        end
      end
      if not duplicated
        @occupant_category.name = name
      else
        session["Occupant category #{@occupant_category.id} error"]  = "Name has been taken."
      end
    end
    
    @occupant_category.movement_behaviors.each do |m|
      @err = Array.new
      if m.isWorking != 0
        m.ATypical = params["movement_behavior_ATypical#{m.id}"]
        m.AStart = params["movement_behavior_AStart#{m.id}"]
        m.AEnd = params["movement_behavior_AEnd#{m.id}"]
        m.GTLTypical = params["movement_behavior_GTLTypical#{m.id}"]
        m.GTLStart = params["movement_behavior_GTLStart#{m.id}"]
        m.GTLEnd = params["movement_behavior_GTLEnd#{m.id}"]
        m.BFLTypical = params["movement_behavior_BFLTypical#{m.id}"]
        m.BFLStart = params["movement_behavior_BFLStart#{m.id}"]
        m.BFLEnd = params["movement_behavior_BFLEnd#{m.id}"]
        m.DTypical = params["movement_behavior_DTypical#{m.id}"]
        m.DStart = params["movement_behavior_DStart#{m.id}"]
        m.DEnd = params["movement_behavior_DEnd#{m.id}"]
        
        m.ownPercent = params["movement_behavior_ownPercent#{m.id}"]
        m.ownDuration = params["movement_behavior_ownDuration#{m.id}"]
        m.otherPercent = params["movement_behavior_otherPercent#{m.id}"]
        m.otherDuration = params["movement_behavior_otherDuration#{m.id}"]
        m.meetingPercent = params["movement_behavior_meetingPercent#{m.id}"]
        m.meetingDuration = params["movement_behavior_meetingDuration#{m.id}"]
        m.auxPercent = params["movement_behavior_auxPercent#{m.id}"]
        m.auxDuration = params["movement_behavior_auxDuration#{m.id}"]
        m.outPercent = 100 - m.ownPercent - m.otherPercent - m.meetingPercent - m.auxPercent
        m.outDuration = params["movement_behavior_outDuration#{m.id}"]
        if m.outPercent < 0
          m.outPercent = 0          
          session["Occupant category #{@occupant_category.id} error"] = "Total percentage should be 100%."
        end
        @err = check_time(m, @err)
      end
      if m.event_type == "Weekend"
        if params["movement_behavior_A#{m.id}"] == "YES"
          m.isWorking = 1
        else
           m.isWorking = 0
        end
        if m.isWorking == 0
          m.ATypical = "00:00"
          m.AStart = "00:00"
          m.AEnd = "00:00"
          m.GTLTypical = "00:00"
          m.GTLStart = "00:00"
          m.GTLEnd = "00:00"
          m.BFLTypical = "00:00"
          m.BFLStart = "00:00"
          m.BFLEnd = "00:00"
          m.DTypical = "00:00"
          m.DStart = "00:00"
          m.DEnd = "00:00"
          m.ownPercent = 0
          m.ownDuration = 0
          m.otherPercent = 0
          m.otherDuration = 0
          m.meetingPercent = 0
          m.meetingDuration = 0
          m.auxPercent = 0
          m.auxDuration = 0
          m.outPercent = 100
          m.outDuration = 0
        end
      end
      if @err.length == 0
        m.save
      else
        session["Occupant category #{@occupant_category.id} error"] = @err[0]
      end
    end
    if params[:commit] == "Delete"
     @occupant_category.destroy
   end
    respond_to do |format|      
      if @occupant_category.save or params[:commit] == "Delete"
        format.html { redirect_to :controller => :occupant_categories, :action => :index, :basic_id=> @basic.id }
      else
        format.html { render :index }
      end
    end
  end
  
  def update_occupant_category
    @occupant_category = @basic.occupant_categories.find(params[:id])
    session["Occupant category #{@occupant_category.id} error"] = nil
    name = params[:name]
    duplicated = false
    if name != @occupant_category.name
      @basic.occupant_categories.each do |ss|
        if ss.name == name 
          duplicated = true
          break
        end
      end
      if not duplicated
        @occupant_category.name = name
      else
        session["Occupant category #{@occupant_category.id} error"]  = "Name has been taken."
      end
    end
    @occupant_category.movement_behaviors.each do |m|
      @err = Array.new
      if m.isWorking != 0
        m.ATypical = params["movement_behavior_ATypical#{m.id}"]
        m.AStart = params["movement_behavior_AStart#{m.id}"]
        m.AEnd = params["movement_behavior_AEnd#{m.id}"]
        m.GTLTypical = params["movement_behavior_GTLTypical#{m.id}"]
        m.GTLStart = params["movement_behavior_GTLStart#{m.id}"]
        m.GTLEnd = params["movement_behavior_GTLEnd#{m.id}"]
        m.BFLTypical = params["movement_behavior_BFLTypical#{m.id}"]
        m.BFLStart = params["movement_behavior_BFLStart#{m.id}"]
        m.BFLEnd = params["movement_behavior_BFLEnd#{m.id}"]
        m.DTypical = params["movement_behavior_DTypical#{m.id}"]
        m.DStart = params["movement_behavior_DStart#{m.id}"]
        m.DEnd = params["movement_behavior_DEnd#{m.id}"]
        
        m.ownPercent = params["movement_behavior_ownPercent#{m.id}"]
        m.ownDuration = params["movement_behavior_ownDuration#{m.id}"]
        m.otherPercent = params["movement_behavior_otherPercent#{m.id}"]
        m.otherDuration = params["movement_behavior_otherDuration#{m.id}"]
        m.meetingPercent = params["movement_behavior_meetingPercent#{m.id}"]
        m.meetingDuration = params["movement_behavior_meetingDuration#{m.id}"]
        m.auxPercent = params["movement_behavior_auxPercent#{m.id}"]
        m.auxDuration = params["movement_behavior_auxDuration#{m.id}"]
        m.outPercent = 100 - m.ownPercent - m.otherPercent - m.meetingPercent - m.auxPercent
        m.outDuration = params["movement_behavior_outDuration#{m.id}"]
        if m.outPercent < 0
          m.outPercent = 0          
          session["Occupant category #{@occupant_category.id} error"] = "Total percentage should be 100%."
        end
        @err = check_time(m, @err)
      end
      if m.event_type == "Weekend"
        if params["movement_behavior_A#{m.id}"] == "YES"
          m.isWorking = 1
        else
           m.isWorking = 0
        end
        if m.isWorking == 0
          m.ATypical = "00:00"
          m.AStart = "00:00"
          m.AEnd = "00:00"
          m.GTLTypical = "00:00"
          m.GTLStart = "00:00"
          m.GTLEnd = "00:00"
          m.BFLTypical = "00:00"
          m.BFLStart = "00:00"
          m.BFLEnd = "00:00"
          m.DTypical = "00:00"
          m.DStart = "00:00"
          m.DEnd = "00:00"
          m.ownPercent = 0
          m.ownDuration = 0
          m.otherPercent = 0
          m.otherDuration = 0
          m.meetingPercent = 0
          m.meetingDuration = 0
          m.auxPercent = 0
          m.auxDuration = 0
          m.outPercent = 100
          m.outDuration = 0
        end
      end
      if @err.length == 0
        m.save
      else
        session["Occupant category #{@occupant_category.id} error"] = @err[0]
      end
    end
    respond_to do |format|
      if params[:commit] == "Save"
        if @err.length != 0
          format.html { redirect_to :controller => :occupant_categories, :action => :forms, :basic_id=> @basic.id, :id=>@occupant_category.id}
        else
          @occupant_category.save
          format.html { render :index }
        end
      elsif params[:commit] == "Cancel"
        @occupant_category.destroy
        format.html { render :index }
      else
        if @occupant_category.save
          format.html { redirect_to :controller => :occupant_categories, :action => :forms, :basic_id=> @basic.id, :id=>@occupant_category.id}
        end
      end
    end
  end
  
  def check_time(m, error)
    check_list = [m.AStart, m.ATypical, m.AEnd, m.GTLStart, m.GTLTypical, m.GTLEnd, m.BFLStart, m.BFLTypical, m.BFLEnd, m.DStart, m.DTypical, m.DEnd]
    digit_list = ["0","1","2","3","4","5","6","7","8","9"]
    format_err = false
    (check_list).each do |str|
      if str.length != 5
        format_err = true
        break
      else
        if str[2] != ":"
          format_err = true
          break
        end
        ([0,1,3,4]).each do |i|
          if digit_list.include?(str[i]) == false
            format_err = true
            break
          end
        end
      end
    end
    if format_err == true
      error.push("Time format should be 'hh:mm'.")
    else
      ([0,3,6,9]).each do |i|
        start_t = check_list[i][0].to_i*600 + check_list[i][1].to_i*60 + check_list[i][3,4].to_i
        typ_t = check_list[i+1][0].to_i*600 + check_list[i+1][1].to_i*60 +  + check_list[i+1][3,4].to_i
        end_t = check_list[i+2][0].to_i*600 + check_list[i+2][1].to_i*60 +  + check_list[i+2][3,4].to_i
        if start_t > typ_t
          error.push( "Typical time should be later than or same as start time.")
          break
        end
        if typ_t > end_t
          error.push("End time should be later than or same as typical time.")
          break
        end
      end
    end
    return error
  end
  
  def create_occupant_category
    @occupant_category = OccupantCategory.new
    @basic.occupant_categories.each do |oc|
      if oc.name == params[:name]
        @error = "Name has been taken."
      end
    end
    if @error == nil
      @occupant_category.name = params[:name]
      @occupant_category.event_type = params[:event_type]
      if @occupant_category.event_type == "Weekday/Weekend"
        args = ["Weekday","Weekend"]
      else
        args = ["All"]
      end
      args.each do |i|
        behavior = MovementBehavior.new   
        behavior.occupant_category = @occupant_category
        behavior.event_type = "#{i}"
        behavior.ATypical = "09:00"
        behavior.AStart = "08:30"
        behavior.AEnd = "09:30"
        behavior.GTLTypical = "12:00"
        behavior.GTLStart = "11:30"
        behavior.GTLEnd = "12:30"
        behavior.BFLTypical = "13:00"
        behavior.BFLStart = "12:30"
        behavior.BFLEnd = "13:30"
        behavior.DTypical = "18:00"
        behavior.DStart = "17:30"
        behavior.DEnd = "18:30"
        
        behavior.ownPercent = 70
        behavior.ownDuration = 60
        behavior.otherPercent = 10
        behavior.otherDuration = 20
        behavior.meetingPercent = 10
        behavior.meetingDuration = 60
        behavior.auxPercent = 5
        behavior.auxDuration = 10
        behavior.outPercent = 5
        behavior.outDuration = 20
        behavior.isWorking = 1
        @occupant_category.movement_behaviors.push(behavior)
      end
      @basic.occupant_categories.push(@occupant_category)
      @basic.save
    end
    respond_to do |format|      
      if @error == nil and @occupant_category.save
        format.html { redirect_to :controller => :occupant_categories, :action => :forms, :basic_id=> @basic.id, :id=>@occupant_category.id }    
      else
        format.html { render :index}
      end
    end
  end

  def destroy
    @occupant_category = @basic.occupant_categories.find(params[:id])
    @occupant_category.destroy
    respond_to do |format|
      format.html { redirect_to :controller => :occupant_categories, :action => :index, :basic_id=> @basic.id }
    end
  end

  private
    def find_basic
      @basic = Basic.find(params[:basic_id])
    end
end
