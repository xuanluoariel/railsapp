# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

office = Basic.create(buildingType:"Office")
residential = Basic.create(buildingType:"Residential")

officeRoom = office.space_categories.create(name: 'Office',density:5)
auxRoom = office.space_categories.create(name: 'Auxiliary',density:0)
officeRoom.occupants.create(occupantType:"Researcher", percentage:80)
officeRoom.occupants.create(occupantType:"Administrater", percentage:15)
officeRoom.occupants.create(occupantType:"Manager", percentage:5)
bedroom = residential.space_categories.create(name: 'Bedroom', density:1)
['Living Room','Other'].each do |rc|
  residential.space_categories.create(name: rc, density:0)
end
['Researcher','Sales','Administrator','Manager'].each do |rc|
  office.occupant_categories.create(name: rc,
                                   ATypical: Time.new(2012, 8, 29, 22, 35, 0), 
                                   AStart: Time.new(2012, 8, 29, 22, 35, 0), 
                                   AEnd: Time.new(2012, 8, 29, 22, 35, 0),
                                   WMTypical: Time.new(2012, 8, 29, 22, 35, 0), 
                                   WMStart: Time.new(2012, 8, 29, 22, 35, 0), 
                                   WMEnd: Time.new(2012, 8, 29, 22, 35, 0),
                                   GTLTypical: Time.new(2012, 8, 29, 22, 35, 0), 
                                   GTLStart: Time.new(2012, 8, 29, 22, 35, 0), 
                                   GTLEnd: Time.new(2012, 8, 29, 22, 35, 0),
                                   BFLTypical: Time.new(2012, 8, 29, 22, 35, 0), 
                                   BFLStart: Time.new(2012, 8, 29, 22, 35, 0), 
                                   BFLEnd: Time.new(2012, 8, 29, 22, 35, 0),
                                   WATypical: Time.new(2012, 8, 29, 22, 35, 0), 
                                   WAStart: Time.new(2012, 8, 29, 22, 35, 0), 
                                   WAEnd: Time.new(2012, 8, 29, 22, 35, 0),
                                   DTypical: Time.new(2012, 8, 29, 22, 35, 0), 
                                   DStart: Time.new(2012, 8, 29, 22, 35, 0), 
                                   DEnd: Time.new(2012, 8, 29, 22, 35, 0),
                                   ownPercent: 65, ownDuration: Time.new(2012, 8, 29, 18, 0, 0),
                                   otherPercent: 5, otherDuration: Time.new(2012, 8, 29, 18, 0, 0),
                                   meetingPercent: 20, meetingDuration: Time.new(2012, 8, 29, 18, 0, 0),
                                   auxPercent: 5, auxDuration: Time.new(2012, 8, 29, 18, 0, 0),
                                   outPercent: 5, outDuration: Time.new(2012, 8, 29, 18, 0, 0))
end
