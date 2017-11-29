
  # {
  #   "rank": 1,
  #   "city": "Bangkok",
  #   "country": "Thailand",
  #   "picture_url": "https://nomadlist.com/assets/img/cities/bangkok-thailand-500px.jpg",
  #   "temperature": 29,
  #   "weather_emoji": "🌤",
  #   "air_quality": {
  #     "above": "AQI",
  #     "value": 53
  #   },
  #   "rent": {
  #     "cost": 1101
  #   }
  #   "wifi": {
  #     "value": 40
  #   },
  #   "score": {
  #     "nomad": 100.0,
  #     "cost": 70.0,
  #     "internet": 80.0,
  #     "fun": 84.255319148936,
  #     "safety": 64.586956521739
  #   }
  # }

City.destroy_all

file              = File.open("db/fixtures/nomad-list-dump.json")
cities_attributes = JSON.parse(file.read)

cities_attributes.each.with_index do |city_attributes, index|
  puts "Creating city ##{index + 1}..."
  usable_attributes = {
    rank:                 city_attributes['rank'],
    name:                 city_attributes['city'],
    country:              city_attributes['country'],
    picture_url:          city_attributes['picture_url'],
    temperature:          city_attributes['temperature'],
    weather_emoji:        city_attributes['weather_emoji'],
    air_quality_above:    city_attributes['air_quality']['above'],
    air_quality_value:    city_attributes['air_quality']['value'],
    rent_cost_per_month:  city_attributes['rent']['cost'].gsub(',', ''),
    wifi_speed:           city_attributes['wifi']['value'],
    score_nomad:          city_attributes['score']['nomad'],
    score_cost:           city_attributes['score']['cost'],
    score_internet:       city_attributes['score']['internet'],
    score_fun:            city_attributes['score']['fun'],
    score_safety:         city_attributes['score']['safety']
  }

  City.create(usable_attributes)
end

puts "Seed finished!"
