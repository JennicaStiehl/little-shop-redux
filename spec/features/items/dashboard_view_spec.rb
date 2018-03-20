RSpec.describe 'Items dashboard' do
  before(:all) do
    DatabaseCleaner.clean
    Item.create(merchant_id: 1,
                title: 'Test Item',
                description: 'description',
                price: 1000,
                image: 'link')
    Item.create(merchant_id: 1,
                title: 'Test Item 2',
                description: 'description',
                price: 1400,
                image: 'link',
                created_at:  Date.parse("2014-04-01"))
    Item.create(merchant_id: 2,
                title: 'Test Item',
                description: 'description',
                price: 1800,
                image: 'link',
                created_at:  Date.parse("2016-04-01"))
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have cards' do
      visit '/items-dashboard'

      expect(page).to have_selector('.card')
      expect(all('.cards').length).to be(3)
    end

    it 'should have the total number of items' do
      visit '/items-dashboard'

      within('.cards .card:first-child') do
        expect(page).to have_content(3)
      end
    end

    it 'should have the average price' do
      visit '/items-dashboard'

      within('.cards .card:nth-child(2)') do
        expect(page).to have_content('$14.00')
      end
    end

    it 'should have newest item' do
      visit '/items-dashboard'

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
      visit '/items-dashboard'

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