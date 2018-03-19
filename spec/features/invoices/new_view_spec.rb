RSpec.describe 'Invoices index' do
  before(:each) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')
    Invoice.create(merchant_id: 1, status: 'pending')
    Invoice.create(merchant_id: 1, status: 'pending')
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have a nav bar' do
      visit '/invoices/new'

      expect(page).to have_selector :css, 'nav p.title'
    end

    it 'should have a header partial' do
      visit '/invoices/new'

      expect(page).to have_selector :css, '.title-container'
    end
  end

  describe 'functionality' do
    it 'should create a new invoice' do
      visit '/invoices'
      expect(page).to have_selector('.collection-item', count: 2)

      visit '/invoices/new'
      select 1, from: 'invoice[merchant_id]'
      fill_in 'invoice[status]', with: 'pending'
      click_on 'Submit'

      expect(current_path).to eq '/invoices'
      expect(page).to have_selector('.collection-item', count: 3)
    end
  end
end
