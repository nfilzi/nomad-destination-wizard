class Cities::Search::Step1aController < ApplicationController
  def show
  end

  def create
    # Steps:
    # 1. Are step params valid?
    # If valid
      # 2. Select 3 countries based on temperature
      # 3. Store them in session
      # 4. redirect to step2
    # Else
      # 2. render :show
    if params_valid?
      session['search'] = {} unless session['search']
      session['search']['countries'] = select_country_names
      redirect_to cities_search_step2_path
    else
      flash.now[:alert] = "Please select your temperature preference."
      render :show
    end
  end

  private

  def params_valid?
    params[:temperature].present?
  end

  def select_country_names
    if params[:temperature] == "hot"
      temperature_condition = "avg(temperature) > 20"
    else
      temperature_condition = "avg(temperature) <= 20"
    end

    City.select("country").
      having(temperature_condition).
      order("count(name) DESC").
      group('country').
      limit(3).
      map(&:country)
  end
end
