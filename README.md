# Simple Weather Forecast

This is a small Ruby on Rails project that enables you to obtain the current weather forecast for a given address or zip code.

* Ruby version: 3.3.8
* Rails version: 8.0
* CSS: Bootstrap 5 CDN

**[VIEW DEMO](https://weather-app-w5zp.onrender.com/)**

## Running the App

1. Bundle gems: `bundle install`
2. Start the server: `rails s`

## How it Works

This relies on two different api services in order to provide the current forecast: Google's Geocode API & WeatherAPI.

* [WeatherAPI](https://www.weatherapi.com/my/): Free open-source API to obtain basic forecast data.
* [Geocode API](https://developers.google.com/maps/documentation/geocoding/overview): API by Google to obtain additional geolocation from a location source.

If you're searching by "Address", it will use Google's Geocode API to obtain the Lat/Long values first before calling the Weather API.

## Testing

Frameworks:
* RSpec
* Capybara
* Selenium

Run tests with `rspec`
