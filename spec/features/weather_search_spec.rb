require 'rails_helper'

RSpec.describe 'Searching for Weather Forecast', type: :system do
  before { visit '/' }
  describe 'weather form' do
    it 'shows the weather search fields' do
      expect(page).to have_content('Weather Forecast')
      expect(page).to have_field('Address')
      expect(page).to have_field('Zip')
    end
  end

  describe 'looking up forecast' do
    context 'when searching by address' do
      let(:address) { '11 Hillside Ave, San Diego, CA' }
      let(:forecast) do
        {
          location: { name: 'San Diego', region: 'CA' },
          current: { temp_f: 100.5, condition: { text: 'Fair weather' } }
        }
      end

      before do
        allow(Weather).to receive(:forecast_by_address).with(address).and_return(forecast)
      end

      it 'shows the proper weather information' do
        fill_in 'Address', with: address
        click_button 'Search'

        within('#weather-results') do
          expect(page).to have_selector('.condition', text: "Fair weather")
          expect(page).to have_selector('.temp', text: 100.5)
          expect(page).to have_selector('.location', text: 'San Diego, CA')
        end
      end
    end

    context 'when searching by zip' do
      let(:zip) { '08080' }
      let(:forecast) do
        {
          location: { name: 'Sewell', region: 'New Jersey' },
          current: { temp_f: 75.2, condition: { text: 'Rainy' } }
        }
      end

      before do
        allow(Weather).to receive(:forecast_by_zip).with(zip).and_return(forecast)
      end

      it 'shows the proper weather information' do
        fill_in 'Zip', with: zip
        click_button 'Search'

        within('#weather-results') do
          expect(page).to have_selector('.condition', text: "Rainy")
          expect(page).to have_selector('.temp', text: 75.2)
          expect(page).to have_selector('.location', text: 'Sewell, New Jersey')
        end
      end
    end

    context 'when zip or address are not provided' do
      it 'shows the proper error message' do
        click_button 'Search'
        within('#weather-results') do
          expect(page).to have_content('You must supply at least an adddress or zip')
        end
      end
    end
  end
end
