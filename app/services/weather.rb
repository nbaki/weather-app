class Weather
  class << self
    # Using address, obtain the lat/long values first before getting the forecast
    def forecast_by_address(address)
      geo = Geokit::Geocoders::MultiGeocoder.geocode(address)
      forecast("#{geo.lat},#{geo.lng}")
    end

    # API call to weatherapi using any valid query parameter (i.e. lat/long, zip)
    # API Response will return error message in their JSON if applicable
    def forecast(query)
      res = HTTParty.get("http://api.weatherapi.com/v1/current.json?key=#{Rails.application.credentials[:WEATHER_API_KEY]}&q=#{query}")
      JSON.parse(res.body).with_indifferent_access
    end

    # Lookup by zip is the same as calling forecast directly, but nicer to have a unique name for the function
    alias forecast_by_zip forecast
  end
end
