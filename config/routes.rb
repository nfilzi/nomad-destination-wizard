Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  # Étapes
  # 1. Get 3 countries
  #   1 Choose 3 countries OR I do not know
  #   OR
  #   1.a Prefer hot or cold temp?
  # 2. Select country (must be signed in)
  # 3. Select nomad score (mockup for diploma of student)
  namespace :cities do
    namespace :search do
      resource :step1,   only: [:show, :create], controller: 'step1'
      resource :step1a,  only: [:show, :create], controller: 'step1a'
      resource :step2,   only: [:show, :create], controller: 'step2'
      resource :step3,   only: [:show, :create], controller: 'step3'
    end
  end

  # FILTERS
  # Score
  #   - cost
  #   - internet
  #   - fun
  #   - safety
  resources :cities, only: :index
end
