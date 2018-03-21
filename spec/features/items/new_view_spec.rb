RSpec.describe 'Items /new' do
  before(:each) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')
    Item.create(merchant_id: 1,
                title: 'Test',
                description: 'description',
                price: 1,
                image: 'link')
    Item.create(merchant_id: 1,
                title: 'Test 2',
                description: 'description 2',
                price: 1,
                image: 'link')
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have a nav bar' do
      visit '/items/new'

      expect(page).to have_selector :css, '.brand-logo'
    end

    it 'should have a header partial' do
      visit '/items/new'

      expect(page).to have_selector :css, '.title-container'
    end
  end

  describe 'functionality' do
    it 'should create a new item' do
      visit '/items'
      expect(page).to have_selector('ul .card', count: 2)

      visit '/items/new'
      select 'Test Merchant', from: 'item[merchant_id]'
      fill_in 'item[title]', with: 'test'
      fill_in 'item[description]', with: 'test'
      fill_in 'item[price]', with: 1200
      fill_in 'item[image]', with: 'http://google.com'
      click_on 'Create Item'

      expect(current_path).to eq '/items'
      expect(page).to have_selector('ul .card', count: 3)
    end

    it 'should be able to cancel the edit' do
      visit '/items/new'

      click_on 'Cancel'

      expect(current_path).to eq '/items'
    end
  end
end
