task merge_pictures_urls_with_json: :environment do
  require "csv"
  filepath = Rails.root.join('db/fixtures/cities.csv')
  cities_pictures = {}
  CSV.foreach(filepath, headers: :first_row) do |row|
    cities_pictures[row['city']] = row['image']
  end

  json_filepath = Rails.root.join('db/fixtures/nomad-list-dump.json')
  file = File.open(json_filepath)
  data = JSON.parse(file.read)
  data.each do |city_attributes|
    picture_url = city_attributes['picture_url']
    next unless picture_url == 'https://nomadlist.com//assets/bg-plane.jpg'
    city_name         = city_attributes['city']
    real_picture_url  = cities_pictures[city_name]
    next unless real_picture_url

    city_attributes['picture_url'] = real_picture_url
  end

  options = {indent: "\t", space: ' '}
  new_json_filepath = Rails.root.join('db/fixtures/new-nomad-list-dump.json')
  File.open(new_json_filepath,"w") do |f|
    f.write(JSON.pretty_generate(data, options))
  end
end
