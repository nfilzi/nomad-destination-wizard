class CitiesController < ApplicationController
  def index
    @selected_country_name = session['search']['country']
    @selected_score_nomad  = session['search']['score_nomad'].to_i

    @cities = City.where(country: @selected_country_name).
      where("score_nomad >= #{@selected_score_nomad}").
      order(:name)
  end
end
