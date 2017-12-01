class Cities::Search::Step3Controller < ApplicationController
  before_action :validate_previous_steps!

  def show
    get_country
  end

  def create
    # Steps:
    # 1. Are step params valid?
    # If valid
      # 2. Store them in session
      # 3. redirect to step3
    # Else
      # 2. render :show
    if params_valid?
      session['search'] = {} unless session['search']
      session['search']['score_nomad'] = params[:score_nomad]
      redirect_to cities_path
    else
      get_country
      flash.now[:alert] = "Please select a nomad score."
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

    # step 2 validation
    step2_valid = session['search']['country'].present?

    unless step2_valid
      flash[:notice] = "Let's go back to the second step"
      return redirect_to cities_search_step2_path
    end
  end

  def params_valid?
    params[:score_nomad].present?
  end

  def get_country
    selected_country_name = session['search']['country']

    @country = City.select("country as name, min(score_nomad) as min_score_nomad, max(score_nomad) as max_score_nomad").
      where(country: selected_country_name).
      group(:country)[0]
  end
end
