Rails.application.routes.draw do
  # Non Sufia generated routes
  mount ProductionCredits::Engine, at: "/production_credits"
  mount RailsAdmin::Engine => '/production_credits/admin', as: 'rails_admin'

  # Sufia generated routes
  blacklight_for :catalog
  devise_for :users
  Hydra::BatchEdit.add_routes(self)
  # This must be the very last route in the file because it has a catch-all route for 404 errors.
    # This behavior seems to show up only in production mode.
    mount Sufia::Engine => '/'
  root to: 'homepage#index'
end
