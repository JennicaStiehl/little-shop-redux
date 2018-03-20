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
      visit '/invoices'

      expect(page).to have_selector :css, '.brand-logo'
    end

    it 'should have a header partial' do
      visit '/invoices'

      expect(page).to have_selector :css, '.title-container'
    end

    it 'should have invoices' do
      visit '/invoices'

      within '.collection' do
        expect(page).to have_content '1'
        expect(page).to have_content '2'
      end
    end
  end

  describe 'links' do
    describe 'dashboard link' do
      it 'should link to /invoices-dashboard' do
        visit '/invoices'

        within 'header' do
          click_on 'Dashboard'
        end

        expect(current_path).to eq '/invoices-dashboard'
      end
    end

    describe 'create new link' do
      it 'should link to /invoices/new' do
        visit '/invoices'

        within 'header' do
          click_on 'Create A New Invoice'
        end

        expect(current_path).to eq '/invoices/new'
      end
    end

    describe 'individual invoice link' do
      it 'should link to /invoices/:id' do
        visit '/invoices'

        within '.collection' do
          click_on '1'
        end

        expect(current_path).to eq '/invoices/1'

        visit '/invoices'

        within '.collection' do
          click_on '2'
        end

        expect(current_path).to eq '/invoices/2'
      end
    end

    describe 'edit invoice link' do
      it 'should link to /invoices/:id/edit' do
        visit '/invoices'

        within first('.secondary-content') do
          find(:css, 'a').click
        end

        expect(current_path).to eq '/invoices/1/edit'
      end
    end

    describe 'delete invoice link' do
      it 'should delete an invoice from list' do
        visit '/invoices'
        expect(page).to have_selector('.collection-item', count: 2)

        within first('.secondary-content') do
          find(:css, 'button').click
        end
        expect(page).to have_selector('.collection-item', count: 1)

        within first('.secondary-content') do
          find(:css, 'button').click
        end
        expect(page).to have_selector('.collection-item', count: 0)
      end
    end
  end
end
