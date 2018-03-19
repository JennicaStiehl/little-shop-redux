RSpec.describe 'Items index' do
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
      visit '/items'

      expect(page).to have_selector :css, '.brand-logo'
    end

    it 'should have a header partial' do
      visit '/items'

      expect(page).to have_selector :css, '.title-container'
    end

    it 'should have items' do
      visit '/items'

      within '.cards' do
        expect(page).to have_content 'Test'
        expect(page).to have_content 'Test 2'
      end
    end
  end

  describe 'links' do
    describe 'dashboard link' do
      it 'should link to /items-dashboard' do
        visit '/items'

        within 'header' do
          click_on 'Dashboard'
        end

        expect(current_path).to eq '/items-dashboard'
      end
    end

    describe 'create new link' do
      it 'should link to /items/new' do
        visit '/items'

        within 'header' do
          click_on 'Create A New Item'
        end

        expect(current_path).to eq '/items/new'
      end
    end

    describe 'individual item link' do
      it 'should link to /items/:id' do
        visit '/items'

        within '.cards' do
          first('.info').click_on 'Test'
        end

        expect(current_path).to eq '/items/1'
      end
    end
  end
end
