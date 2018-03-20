RSpec.describe 'Merchants /edit' do
  before(:each) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have a nav bar' do
      visit '/merchants/1/edit'

      expect(page).to have_selector :css, '.brand-logo'
    end

    it 'should have a header partial' do
      visit '/merchants/1/edit'

      expect(page).to have_selector :css, '.title-container'
    end
  end

  describe 'functionality' do
    it 'should create a new merchant' do
      visit '/merchants/1'
      expect(page).to have_content 'Test Merchant'

      visit '/merchants/1/edit'
      fill_in 'merchant[name]', with: 'Test Update'
      click_on 'Update Merchant'

      expect(current_path).to eq '/merchants/1'
      expect(page).to have_content 'Test Update'
    end
  end
end
