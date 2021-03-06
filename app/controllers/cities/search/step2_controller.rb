class Cities::Search::Step2Controller < ApplicationController
  skip_before_action :authenticate_user!

  before_action :validate_previous_steps!

  def show
    get_countries
  end

  def create
    # Steps:
    # 1. Are step params valid?
    # If valid
      # 2. Store them in session
      # If user signed in?
        # 3. redirect to step3
      # Else
        # 3. redirect to sign-in and then step3
    # Else
      # 2. render :show
    if params_valid?
      session['search'] = {} unless session['search']
      session['search']['country'] = params[:country]

      if user_signed_in?
        redirect_to cities_search_step3_path
      else
        store_location_for(:user, cities_search_step3_path)
        authenticate_user!
      end
    else
      get_countries
      flash.now[:alert] = "Please select a country."
      render :show
    end
  end

  private

  def validate_previous_steps!
    # step 1 validation
    countries   = session['search']['countries'] if session['search']
    step1_valid = countries.present? && countries.size == 3

    unless step1_valid
      flash[:notice] = "Let's start from the first step"
      return redirect_to cities_search_step1_path
    end
  end

  def params_valid?
    params[:country].present?
  end

  def get_countries
    selected_countries_names = session['search']['countries']

    @countries = City.select(<<~EOF
        country AS name,
        count(name) AS cities_count,
        avg(rent_cost_per_month) AS avg_price,
        avg(temperature) AS avg_temp,
        min(weather_emoji) AS weather_emoji,
        min(picture_url) AS picture_url
      EOF
      ).
      where(country: selected_countries_names).
      order(:country).
      group(:country)
  end
end
