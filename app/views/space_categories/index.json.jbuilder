json.array!(@space_categories) do |space_category|
  json.extract! space_category, :id, :name, :area, :density, :basic_id
  json.url space_category_url(space_category, format: :json)
end
