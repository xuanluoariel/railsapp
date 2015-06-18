json.array!(@basics) do |basic|
  json.extract! basic, :id, :type, :startTime, :endTime, :timeStep
  json.url basic_url(basic, format: :json)
end
