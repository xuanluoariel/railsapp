class BasicsController < ApplicationController
  # before_action :set_basic
  def init_default(building_type)
    cur_dir = Rails.root.join('db').to_s
    database= SQLite3::Database.new(cur_dir+"/input.sqlite3")
    
    table_name = "occupant_input"
    column_name = "building_type_name"
    command = "SELECT * FROM #{table_name} WHERE"
    command += " #{column_name}= '#{building_type}'"   
    objs = database.execute(command)   
    if objs.length >= 1
      init_default_occupant_types(objs)
    end
    
    table_name = "building_input"
    command = "SELECT * FROM #{table_name} WHERE"
    command += " #{column_name} = '#{building_type}'"   
    objs = database.execute(command)   
    if objs.length >= 1
      init_default_spaces(objs)
    end
  end
  
  def init_default_occupant_types(objs)
    i = 0
    while (i<objs.length)
      occupant_category = OccupantCategory.new
      occupant_category.basic = @basic
      occupant_category.name = "#{objs[i][0]}"
      occupant_category.event_type = "#{objs[i][2]}"
      args = Array.new
      if occupant_category.event_type == "Weekday/Weekend"
        args = ["Weekday","Weekend"]
      else
        args = ["All"]
      end
      basic = @basic
      init_default_behaviors(basic, occupant_category, args)
      @basic.occupant_categories.push(occupant_category)
      @basic.save
      i+=1
    end
  end
  
  def init_default_behaviors(basic, occupant_category, args)
    cur_dir = Rails.root.join('db').to_s
    database= SQLite3::Database.new(cur_dir+"/input.sqlite3")
    table_name = "movement_input"
    column_1_name = "building_type_name"
    column_2_name = "occupant_type_name"
    column_3_name = "movement_behavior_type"
    args.each do |i|
      command = "SELECT * FROM #{table_name} WHERE"
      command += " #{column_1_name}= '#{basic.buildingType}'"
      command += " AND #{column_2_name}= '#{occupant_category.name}'"
      command += " AND #{column_3_name}= '#{i}'"  
      objs = database.execute(command)
      behavior = MovementBehavior.new   
      behavior.occupant_category = occupant_category
      behavior.event_type = "#{i}"
      behavior.ATypical = "#{objs[0][4]}:#{objs[0][5]}"
      behavior.AStart = "#{objs[0][6]}:#{objs[0][7]}"
      behavior.AEnd = "#{objs[0][8]}:#{objs[0][9]}"
      behavior.GTLTypical = "#{objs[0][10]}:#{objs[0][11]}"
      behavior.GTLStart = "#{objs[0][12]}:#{objs[0][13]}"
      behavior.GTLEnd = "#{objs[0][14]}:#{objs[0][15]}"
      behavior.BFLTypical = "#{objs[0][16]}:#{objs[0][17]}"
      behavior.BFLStart = "#{objs[0][18]}:#{objs[0][19]}"
      behavior.BFLEnd = "#{objs[0][20]}:#{objs[0][21]}"
      behavior.DTypical = "#{objs[0][22]}:#{objs[0][23]}"
      behavior.DStart = "#{objs[0][24]}:#{objs[0][25]}"
      behavior.DEnd = "#{objs[0][26]}:#{objs[0][27]}"
      
      behavior.ownPercent = "#{objs[0][28]}".to_i
      behavior.ownDuration = "#{objs[0][29]}".to_i
      behavior.otherPercent = "#{objs[0][30]}".to_i
      behavior.otherDuration = "#{objs[0][31]}".to_i
      behavior.meetingPercent = "#{objs[0][32]}".to_i
      behavior.meetingDuration = "#{objs[0][33]}".to_i
      behavior.auxPercent = "#{objs[0][34]}".to_i
      behavior.auxDuration = "#{objs[0][35]}".to_i
      behavior.outPercent = "#{objs[0][36]}".to_i
      behavior.outDuration = "#{objs[0][37]}".to_i
      behavior.isWorking = "#{objs[0][38]}".to_i
      occupant_category.movement_behaviors.push(behavior)
    end
  end
  
  def init_default_spaces(objs)
    i = 0
    building_area = 0
    while (i<objs.length)
      space_category = SpaceCategory.new
      space_category.basic = @basic
      space_category.name = "#{objs[i][1]}"
      space_category.usage = "#{objs[i][7]}"
      space_category.density = "#{objs[i][6]}".to_i
      space_category.max_num = "#{objs[i][10]}".to_i
      space_category.min_num = "#{objs[i][11]}".to_i
      if space_category.usage == "Office"
        init_default_occupants(space_category)
      elsif space_category.usage == "Meeting room"
        meeting_ids = ["#{objs[i][8]}".to_i, "#{objs[i][9]}".to_i]
        init_default_meetings(space_category,meeting_ids)
      end
      @basic.space_categories.push(space_category)
      
      space = Space.new
      space.basic = @basic
      space.name = "Space #{objs[i][0]}"
      space.spaceType = space_category.name      
      space.area = "#{objs[i][5]}".to_i
      area_perc = "#{objs[i][4]}".to_i
      space.multiplier = (@basic.total_area*area_perc*0.01/space.area).round.to_i
      if space.multiplier < 1
        space.multiplier = 1
      end
      spaceType = @basic.space_categories.find_by name:space.spaceType
      if spaceType.usage == "Office" 
        space.occupant_num = (space.area/spaceType.density).round.to_i
      else
        space.occupant_num = 0
      end
      building_area += space.multiplier*space.area
      @basic.spaces.push(space)
      
      i+=1
    end
    spaceNum = 0
    @basic.spaces.each do |spc|
      spaceNum += spc.multiplier
    end
    @basic.space_num = spaceNum
    @basic.total_area = building_area
    @basic.save
  end
  
  def init_default_occupants(space_category)
    cur_dir = Rails.root.join('db').to_s
    database= SQLite3::Database.new(cur_dir+"/input.sqlite3")
    table_name = "space_input"
    column_name = "space_type_name"
    command = "SELECT * FROM #{table_name} WHERE"
    command += " #{column_name}= '#{space_category.name}'"   
    objs = database.execute(command)
  
    if (objs.length >= 1)
      i = 0
      while (i<objs.length)
        occupant = Occupant.new
        occupant.space_category = space_category
        occupant.occupantType = "#{objs[i][3]}"
        occupant.percentage = "#{objs[i][4]}".to_i
        space_category.occupants.push(occupant)
        i+=1
      end
    else
      @error = "Wrong input."
    end
  end
  
  def init_default_meetings(space_category, meeting_ids)
    cur_dir = Rails.root.join('db').to_s
    database= SQLite3::Database.new(cur_dir+"/input.sqlite3")
    table_name = "meeting_input"
    column_name = "meeting_id"
    (meeting_ids).each do |id|
      command = "SELECT * FROM #{table_name} WHERE"
      command += " #{column_name}= '#{id}'"   
      objs = database.execute(command)
      
      if (objs.length >= 1)
        i = 0
        while (i<objs.length)
          meeting = Meeting.new
          meeting.space_category = space_category
          meeting.duration = "#{objs[i][1]}".to_i
          meeting.start_time = "#{objs[i][2]}:#{objs[i][3]}"
          meeting.end_time = "#{objs[i][4]}:#{objs[i][5]}"
          meeting.prob = "#{objs[i][6]}".to_i
          meeting.time_range = "#{objs[i][7]}"
          space_category.meetings.push(meeting)
          i+=1
        end
      end
    end
  end
  
  def edit
    @basic = Basic.find(params[:id])
  end
  
  def update_building
    @basic = Basic.find(params[:id])
    @basic.buildingType = params["basic_buildingType#{@basic.id}"]
    @basic.total_area = params["basic_total_area#{@basic.id}"]
    @basic.save
    respond_to do |format|
      format.html {  render :action=>:edit }
    end
  end
  
  def update_zone
    @basic = Basic.find(params[:id])
    @basic.spaces.each do |s|
      duplicated = false
      s.name = params["space_name#{s.id}"]
      s.spaceType = params["space_spaceType#{s.id}"]
      s.multiplier = params["space_multiplier#{s.id}"]
      s.area = params["space_area#{s.id}"]
      spaceType = @basic.space_categories.find_by name:s.spaceType
      if spaceType.usage == "Office" 
        s.occupant_num = (s.area/spaceType.density).round.to_i
      else
        s.occupant_num = 0
      end
      @basic.spaces.each do |ss|
        if (ss.id < s.id) and (ss.name == s.name)
          duplicated = true
        end
      end
      if not duplicated
        if not s.save
          s.errors.each do |attr, msg|
            @basic.errors["#{s.name}: #{attr}"]= msg
          end
        end
      else
        @basic.errors["#{s.name}"]= "name has been taken."
      end
    end

    if params[:commit] == "Add new space"
      space = Space.new
      space.basic = @basic
      number = 0
      while true
        s = Space.find_by_name("Space #{number+1}")
        if s == nil
          break
        else
          number += 1 
        end
      end
      space.name = "Space #{number+1}"
      space.spaceType = "Office - Private"
      space.multiplier = 1
      space.area = 700
      spaceType = @basic.space_categories.find_by name:space.spaceType
      if spaceType.usage == "Office" 
        space.occupant_num = (space.area/spaceType.density).round.to_i
      else
        space.occupant_num = 0
      end
      if not space.save
        space.errors.each do |attr, msg|
          @basic.errors["Space #{space.id}: #{attr}"]= msg
        end
      end
      @basic.spaces.push(space)
      
    end
    building_area = 0
    spaceNum = 0
    @basic.spaces.each do |sp|
      building_area += sp.area*sp.multiplier
      spaceNum += sp.multiplier
    end
    @basic.space_num = spaceNum
    @basic.total_area = building_area
    @basic.save
    respond_to do |format|
      format.html {  render :action=>:edit }
    end
  end
  
  def continue_session
    if Basic.exists?(:session_number=> params[:preSessionNo])
      @basic = Basic.where(:session_number=>params[:preSessionNo]).first  
      session[:bldg_id]= params[:preSessionNo]
      respond_to do |format|
        format.html {  render :edit }
      end
    else
      session[:bldg_id] = nil
      @error = "Cant find the account with the session number. Please try again or start a new session."
      respond_to do |format|
        # format.html { render :controller=>:pages, :action=> :edit}
        format.html { render "pages/welcome"}
      end
    end
  end

  # POST /basics
  def new
    @basic = Basic.new
    @basic.buildingType = params[:buildingType]
    @basic.total_area = params[:area]
    @basic.start_year = 2015
    @basic.start_mon = 1
    @basic.start_day = 1
    @basic.end_mon = 1
    @basic.end_day = 1
    @basic.time_step = 5
    if not @basic.save(:validate => false)
      raise "cant save the @basic"
    end
    @basic.session_number = @basic.id * 10000 + rand(10000)
    if @basic.save
      init_default(@basic.buildingType)
    end
    respond_to do |format|
      if @basic.save
        format.html { redirect_to edit_basic_path(@basic), notice: 'Basic was successfully created.' }
      else
        format.html { render root_path}
      end
    end
  end
  
  def simulate_input
    @basic = Basic.find(params[:id])
    mon_list = ["Jan", "Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    if params[:year] != nil
      @basic.start_year = params[:year].to_i
      @basic.start_mon = mon_list.index(params[:s_mon]).to_i+1
      @basic.start_day = params[:s_day].to_i
      @basic.end_mon = mon_list.index(params[:e_mon]).to_i+1
      @basic.end_day = params[:e_day].to_i

      if get_day_num(@basic.start_year, @basic.start_mon, @basic.start_day) > get_day_num(@basic.start_year, @basic.end_mon, @basic.end_day)
        @error = "Start date must be previous to end date!"
      end
      @time_step = params[:time_step]
      case params[:time_step]
        when "5 min"
          @basic.time_step = 5
        when "10 min"
          @basic.time_step = 10
        when "15 min"
          @basic.time_step = 15
        when "20 min"
          @basic.time_step = 20
        else
          @basic.time_step = 10
      end
    end
    if @basic.save and @error == nil
      if params[:commit] == "Simulate"
        output_path = Rails.root.join('db', 'user_data',"output_#{@basic.session_number}_package").to_s
        solver_path = Rails.root.join('solver/').to_s
        if not File.exist? output_path
          Dir.mkdir(output_path)
          sleep(0.1)
        end
        xml_file_name = output_path + "/temp.xml"
        output_file_name = output_path + "/output.csv"
        write_xml(xml_file_name)
        system(solver_path+'obFMU.exe', xml_file_name, output_file_name, @basic.start_year.to_s, @basic.start_mon.to_s, @basic.start_day.to_s, @basic.end_mon.to_s, @basic.end_day.to_s, @basic.time_step.to_s)
        
      end
      
    end
    room_list = Array.new
    @basic.spaces.each do |sp|
      i = 1
      while (i<=sp.multiplier)
        room_list.push("#{sp.spaceType} - #{i}")
        i += 1
      end
    end
    if params[:room_num]!=nil
      @room_num = room_list.index(params[:room_num])+1
    end
    display(@basic)
    respond_to do |format|
      @basic.save
      format.html { render "basics/simulate"}
    end
  end
  
  def display(basic)
    @user_hash_array = Array.new
    output_path = Rails.root.join('db', 'user_data',"output_#{basic.session_number}_package").to_s
    output_file_name = output_path + "/output.csv"
    @display_array = Array.new
    if File.exist?(output_file_name)
      @user_hash_array = CSV.read(output_file_name)
      if @user_hash_array != nil
        @user_hash_array.each_with_index do |row, index|
          if index > 1
            interval = 1000*60*basic.time_step
            time_tag = get_day_num(basic.start_year, basic.start_mon, basic.start_day)*24*3600*1000 + index*interval 
            if @room_num != nil
              @display_array.push([time_tag, row[@room_num.to_i+2].to_i])
            else
              @room_num = 1
              @display_array.push([time_tag, row[3].to_i])
            end
          end
        end
      end
    end
  end
  
  def get_day_num(year, mon, day)
    num = 0
    
    k = 1
    while (k<mon)
      numdays = 31
      if (k == 2)
        if (year%400 == 0 or (year%4==0 and year%100!=0))
          numdays = 29
        else
          numdays = 28
        end
      elsif (k == 4 or k == 6 or k == 9 or k == 11)
        numdays = 30
      end
      num += numdays
      k+=1
    end
    num += day-1
    return num
  end
  
  helper_method :display
  helper_method :get_day_num
  
  def download_files
    @basic = Basic.find(params[:id])
    zipfile_dir = Rails.root.join('public',"output_Files").to_s
    if not File.exist? zipfile_dir
      Dir.mkdir(zipfile_dir)
      sleep(1)
    end
    zipfile_filename =zipfile_dir +  "/output_#{@basic.session_number}.zip"
    if File.exist? zipfile_filename
      FileUtils.rm_rf(zipfile_filename)
      sleep(1)
    end

    Zip::ZipFile.open(zipfile_dir + "/output_#{@basic.session_number}.zip", Zip::ZipFile::CREATE) {
      |zipfile|

      # Find files used for simulation
      single_output_dir = Rails.root.join('db', 'user_data',"output_#{@basic.session_number}_package").to_s
      if File.exist? single_output_dir
        baseline_filename = single_output_dir + "/output.csv"
        if File.exist? baseline_filename
          add_file_to_zipfile(zipfile,"Schedule output.csv",baseline_filename)
        end
      end
    }

    respond_to do |format|
      format.html {  redirect_to "/output_Files/output_#{@basic.session_number}.zip" }
    end
  end

  def add_file_to_zipfile(zipfile, filename, source_filename)
    zipfile.get_output_stream(filename) do |file|
      source_texts = File.readlines(source_filename)
      source_texts.each do |text|
        file.write(text + "\n")
      end
    end
  end 
 
  def write_xml(file_name)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.OccupantBehavior('xmlns'=>'http://www.obxml.org/schema/0-1', 'version'=>'1.0', 'useSIUnitsForResults'=>'true') {
        write_buildings(xml)
        write_occupants(xml)
        write_behaviors(xml)
      }
    end
    results = builder.to_xml
    f = File.open(file_name, 'w')
    f.write(results.to_str)
    f.close
  end
  
  def write_buildings(xml)
    basic = @basic
    xml.Buildings {
      xml.Building('ID'=>'B1') {
        xml.Description "A office building which contains 12 space and 16 staffs."
        xml.Address "Tsinghua University China"
        if @basic.buildingType == "Office - Large" or @basic.buildingType == "Office - Small"
          xml.Type "Office"
        else
          xml.Type "Residential"
        end
        xml.Spaces {
          xml.Space('ID'=> "S0") {
            xml.Type "Outdoor"
          }
          spaceNum = 0
          
          basic.spaces.each do |space|
            write_spaces(xml, space, spaceNum)
            spaceNum += space.multiplier
          end
          @basic.space_num = spaceNum
        } 
      }
    }
  end
  
  def write_spaces(xml, space, spaceNum)
    i = 1
    while (i<=space.multiplier) 
      xml.Space('ID'=> "S"+(spaceNum+i).to_s) {
        spaceType = @basic.space_categories.find_by name:space.spaceType
        if spaceType.usage == "Office"
          xml.Type "OfficeShared"
          occupantId = 0
          occupantNum = (space.area/spaceType.density).round.to_i
          j = 1
          while (j<=occupantNum)
            xml.OccupantID "S"+(spaceNum+i).to_s+"O"+(occupantId+j).to_s
            j += 1
          end
        elsif spaceType.name != nil
          if spaceType.usage == "Meeting room"
            xml.Type "MeetingRoom"
            xml.Meetings {
              spaceType.meetings.each_with_index do |meeting, index|
                meetingId = "S" + (spaceNum+i).to_s + "M" + index.to_s
                write_meetings(xml, meetingId, meeting)
              end
            }
          else
            xml.Type space.spaceType
          end
          xml.MaxNumOccupants spaceType.max_num
          xml.MinNumOccupants spaceType.min_num
        end
      }
      i += 1 
    end  
  end
  
  def write_meetings(xml, meetingId, meeting)
    xml.Meeting('ID'=> meetingId) {
      xml.Duration meeting.duration
      xml.StartTime meeting.start_time
      xml.EndTime meeting.end_time
      xml.Probability meeting.prob*0.01
    }
  end
  
  def write_occupants(xml)
    xml.Occupants {
      spaceNum = 0
      @basic.spaces.each do |space|
        i = 1
        spaceType = @basic.space_categories.find_by name:space.spaceType        
        while (i<=space.multiplier)
          if spaceType.usage == "Office" 
            occupantNo = 0
            occupantNum = (space.area/spaceType.density).round.to_i
            j = 1
            while (j<=occupantNum)
              prng = Random.new
              prob = prng.rand(1.0) 
              last_prob = 0
              occupantType = nil              
              spaceType.occupants.each do |occupant|                
                this_prob = last_prob + occupant.percentage*0.01
                if prob >= last_prob and prob < this_prob
                  occupantType = occupant.occupantType                  
                end
                last_prob = this_prob
              end
              if occupantType == nil
                occupantType = spaceType.occupants.first.occupantType                
              end
              occupantId = "S"+(spaceNum+i).to_s+"O"+(occupantNo+j).to_s
              write_occupant(xml, occupantId, occupantType)
              j += 1
            end
          end
          i += 1
        end
        spaceNum += space.multiplier
      end
    }  
  end
  
  def write_occupant(xml,occupantId,occupantType)
    xml.Occupant('ID'=> occupantId) {
      xml.JobType occupantType
      xml.LifeStyle "Norm"
      occupantType = @basic.occupant_categories.find_by name:occupantType
      occupantType.movement_behaviors.each_with_index do |behavior, index|
        behaviorId = occupantType.name + behavior.event_type
        xml.BehaviorID behaviorId
      end
    }
  end
  
  def write_behaviors(xml)
    xml.Behaviors {
      @basic.occupant_categories.each do |occupantType|
        occupantType.movement_behaviors.each_with_index do |behavior, index|
          behaviorId = occupantType.name + behavior.event_type
          xml.Behavior('ID'=> behaviorId){
            xml.Drivers {
              xml.Time {
                xml.DayofWeek behavior.event_type
              }
            }
            xml.Actions {
              xml.Movement {
                xml.MarkovChainModel {
                  xml.Events {
                    write_events(xml, behavior)
                  }
                  xml.SpaceOccupancies {
                    write_space_occupancys(xml, behavior)
                  }
                }
              }
            }
          }
        end
      end
    }
  end
  
  
  
  def write_events(xml, behavior)
    xml.Event {
      xml.Type "Arrival"
      xml.TypicalTime behavior.ATypical
      xml.StartTime behavior.AStart
      xml.EndTime behavior.AEnd
    }
    xml.Event {
      xml.Type "WorkMorning"
      xml.TypicalTime behavior.AEnd
      xml.StartTime behavior.AEnd
      xml.EndTime behavior.GTLStart
    }
    xml.Event {
      xml.Type "GoToLunch"
      xml.TypicalTime behavior.GTLTypical
      xml.StartTime behavior.GTLStart
      xml.EndTime behavior.GTLEnd
    }
    xml.Event {
      xml.Type "BackFromLunch"
      xml.TypicalTime behavior.BFLTypical
      xml.StartTime behavior.BFLStart
      xml.EndTime behavior.BFLEnd
    }
    xml.Event {
      xml.Type "WorkAfternoon"
      xml.TypicalTime behavior.BFLEnd
      xml.StartTime behavior.BFLEnd
      xml.EndTime behavior.DStart
    }
    xml.Event {
      xml.Type "Departure"
      xml.TypicalTime behavior.DTypical
      xml.StartTime behavior.DStart
      xml.EndTime behavior.DEnd
    }
  end
  
  def write_space_occupancys(xml, behavior)
    xml.SpaceOccupancy {
      xml.SpaceCategory "OwnOffice"
      xml.PercentTimePresence behavior.ownPercent
      xml.Duration behavior.ownDuration
    }
    xml.SpaceOccupancy {
      xml.SpaceCategory "OtherOffice"
      xml.PercentTimePresence behavior.otherPercent
      xml.Duration behavior.otherDuration
    }
    xml.SpaceOccupancy {
      xml.SpaceCategory "MeetingRoom"
      xml.PercentTimePresence behavior.meetingPercent
      xml.Duration behavior.meetingDuration
    }
    xml.SpaceOccupancy {
      xml.SpaceCategory "AuxRoom"
      xml.PercentTimePresence behavior.auxPercent
      xml.Duration behavior.auxDuration
    }
    xml.SpaceOccupancy {
      xml.SpaceCategory "Outdoor"
      xml.PercentTimePresence behavior.outPercent
      xml.Duration behavior.outDuration
    }
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def basic_params
      params.require(:basic).permit(:buildingType)
    end
end
