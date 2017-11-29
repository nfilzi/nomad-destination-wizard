class Cities::Search::Step1Controller < ApplicationController
  skip_before_action :authenticate_user!

  def show
    get_countries
  end

  def create
    # Steps:
    # 0. Does the person has an idea of countries?
      # nope? redirect to step1a
    # 1. Are step params valid?
    # If valid
      # 2. Store them in session
      # 3. redirect to step2
    # Else
      # 2. render :show
    if no_countries_idea?
      redirect_to cities_search_step1a_path
    elsif params_valid?
      session['search'] = {} unless session['search']
      session['search']['countries'] = params[:countries]
      redirect_to cities_search_step2_path
    else
      get_countries
      flash.now[:alert] = "Please select 3 countries."
      render :show
    end
  end


  private

  def no_countries_idea?
    params[:no_countries] == "true"
  end

  def params_valid?
    submitted_countries = params[:countries]
    submitted_countries.present? && submitted_countries.size == 3
  end

  def get_countries
    @countries = City.select("country, count(name)").
      group("country").
      having("count(name) > 1").
      order("country").
      uniq.
      pluck(:country)
  end
end
