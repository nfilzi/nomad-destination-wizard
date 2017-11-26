class Cities::Search::Step3Controller < ApplicationController
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
