Rails.application.routes.draw do
  namespace :forecasts do
    post "search"
    get "current"
  end

  root to: "forecasts#current"
end
