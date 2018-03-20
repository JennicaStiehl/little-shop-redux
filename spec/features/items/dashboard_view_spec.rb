RSpec.describe 'Items dashboard' do
  describe 'content' do
    it 'should have cards' do
      visit '/item-dashboard'

      expect(page).to have_selector('.card')
      expect(all('.cards').length).to be(3)
    end

    it 'should have the total number of items' do
      visit '/item-dashboard'

      within('.cards .card:first-child') do
        expect(page).to have_content(3)
      end
    end

    it 'should have the average price' do
      visit '/item-dashboard'

      within('.cards .card:nth-child(2)') do
        expect(page).to have_content('$0.00')
      end
    end

    it 'should have newest item' do
      within('.cards .card:last-child') do
        within('li:first-child') do
          exepect(page).to have_content('Newest')
          expect(page).to have_content('')

          find('a').click

          expect(current_path).to eq('/items/1')
        end
      end
    end

    it 'should have oldest item' do
      within('.cards .card:last-child') do
        within('li:last-child') do
          exepect(page).to have_content('Oldest')
          expect(page).to have_content('')

          find('a').click

          expect(current_path).to eq('/items/2')
        end
      end
    end
  end
end