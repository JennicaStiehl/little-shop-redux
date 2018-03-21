RSpec.describe 'Merchants /new' do
  before(:each) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have a nav bar' do
      visit '/merchants/new'

      expect(page).to have_selector :css, '.brand-logo'
    end

    it 'should have a header partial' do
      visit '/merchants/new'

      expect(page).to have_selector :css, '.title-container'
    end
  end

  describe 'functionality' do
    it 'should create a new merchant' do
      visit '/merchants'
      expect(page).to have_selector('ul .collection-item', count: 1)

      visit '/merchants/new'
      fill_in 'merchant[name]', with: 'Test 2'
      click_on 'Create Merchant'

      expect(current_path).to eq '/merchants'
      expect(page).to have_selector('ul .collection-item', count: 2)
    end
  end
end
