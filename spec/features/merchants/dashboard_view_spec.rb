RSpec.describe 'Merchants /merchants-dashboard' do
  before(:each) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')
    Merchant.create(name: 'Merchant 2')
    Item.create(merchant_id: 1,
                title: 'Test Item',
                description: 'description',
                price: 1,
                image: 'link')
    Item.create(merchant_id: 1,
                title: 'Test 2',
                description: 'description 2',
                price: 1,
                image: 'link')
    Item.create(merchant_id: 2,
                title: 'Test 2',
                description: 'description 2',
                price: 200,
                image: 'link')
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have a nav bar' do
      visit '/merchants-dashboard'

      expect(page).to have_selector :css, '.brand-logo'
    end

    it 'should have a header partial' do
      visit '/merchants-dashboard'

      expect(page).to have_selector :css, '.title-container'
    end
  end

  describe 'functionality' do
    it 'should display top merchants' do
      visit '/merchants-dashboard'

      expect(page).to have_css('.summary')
    end

    it 'should have all merchant cards' do
      visit '/merchants-dashboard'

      expect(page).to have_css('.card', count: 2)
    end

    it 'each card should have item count' do
    end

    it 'each card should have avg item price' do
    end

    it 'each card should have total cost' do
    end
  end
end
