class ForecastsController < ApplicationController
  def current
  end

  # Search forecast
  def search
    fresh_zip_forecast = false

    weather = if forecast_params[:address].present?
      Weather.forecast_by_address(forecast_params[:address])
    elsif forecast_params[:zip].present?
      Rails.cache.fetch("weather-forecast-#{forecast_params[:zip]}", expires_in: 30.minutes) do
        fresh_zip_forecast = true # Indicator when this is the first time we're caching by ZIP
        Weather.forecast_by_zip(forecast_params[:zip])
      end
    else
      # Use same error format as API response
      { error: { message: "You must supply at least an adddress or zip" } }
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          # Turbo update the "weather-results" frame with a new set of results
          turbo_stream.update(
            "weather-results",
            partial: "forecasts/results",
            locals: {
              weather: weather[:current], location: weather[:location], error: weather[:error], fresh_zip_forecast:, zip: forecast_params[:zip].presence
            }
          )
        ]
      end
    end
  end

  private

  def forecast_params
    params.require(:forecast).permit(:address, :zip)
  end
end
