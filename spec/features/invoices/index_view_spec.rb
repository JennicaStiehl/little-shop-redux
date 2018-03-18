RSpec.describe 'Invoice index' do
  describe 'content' do
    it 'should have a nav bar' do
      visit '/invoices'

      expect(page).to have_selector :css, 'nav p.title'
    end

    it 'should have a header partial' do
      visit '/invoices'

      expect(page).to have_selector :css, '.title-container'
    end

    it 'should have invoices' do
      Invoice.create(merchant_id: 1, status: 'pending')
      Invoice.create(merchant_id: 1, status: 'pending')

      visit '/invoices'

      within '.collection' do
        expect(page).to have_content '1'
        expect(page).to have_content '2'
      end
    end
  end

  describe 'links' do

  end
end
