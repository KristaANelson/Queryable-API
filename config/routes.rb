Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        get "/providers", to: "providers#index"
      end
    end
end
