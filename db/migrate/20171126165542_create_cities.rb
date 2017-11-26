class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.integer   :rank
      t.string    :name
      t.string    :country
      t.string    :picture_url
      t.string    :temperature
      t.string    :weather_emoji
      t.string    :air_quality_above
      t.integer   :air_quality_value
      t.integer   :rent_cost_per_month
      t.integer   :wifi_speed
      t.float     :score_nomad
      t.float     :score_cost
      t.float     :score_internet
      t.float     :score_fun
      t.float     :score_safety

      t.timestamps
    end
  end
end
