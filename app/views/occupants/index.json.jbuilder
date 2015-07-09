json.array!(@occupants) do |occupant|
  json.extract! occupant, :id, :occupantType, :percentage, :SpaceCategory_id
  json.url occupant_url(occupant, format: :json)
end
