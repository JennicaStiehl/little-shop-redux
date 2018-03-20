RSpec.describe 'Merchants index' do
  before(:each) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')
    Merchant.create(name: 'Test Merchant 2')
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

    it 'should have merchants' do
      visit '/merchants'

      within '.collection' do
        expect(page).to have_content 'Test Merchant'
        expect(page).to have_content 'Test Merchant 2'
      end
    end
  end

  describe 'links' do
    describe 'dashboard link' do
      it 'should link to /merchants-dashboard' do
        visit '/merchants'

        within 'header' do
          click_on 'Dashboard'
        end

        expect(current_path).to eq '/merchants-dashboard'
      end
    end

    describe 'create new link' do
      it 'should link to /merchants/new' do
        visit '/merchants'

        within 'header' do
          click_on 'Create A New Merchant'
        end

        expect(current_path).to eq '/merchants/new'
      end
    end

    describe 'individual invoice link' do
      it 'should link to /merchants/:id' do
        visit '/merchants'

        within '.collection' do
          click_on 'Test Merchant'
        end

        expect(current_path).to eq '/merchants/1'

        visit '/merchants'

        within '.collection' do
          click_on 'Test Merchant 2'
        end

        expect(current_path).to eq '/merchants/2'
      end
    end

    describe 'edit merchant link' do
      it 'should link to /merchants/:id/edit' do
        visit '/merchants'

        within first('.secondary-content') do
          find(:css, 'a').click
        end

        expect(current_path).to eq '/merchants/1/edit'
      end
    end

    describe 'delete merchant link' do
      it 'should delete an merchant from list' do
        visit '/merchants'
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
