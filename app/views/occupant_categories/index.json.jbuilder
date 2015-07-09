json.array!(@occupant_categories) do |occupant_category|
  json.extract! occupant_category, :id, :name, :GTWTypical, :GTWStart, :GTWEnd
  json.url occupant_category_url(occupant_category, format: :json)
end
