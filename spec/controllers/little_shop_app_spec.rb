RSpec.describe LittleShopApp do
  describe 'paths' do
    before(:each) do
      DatabaseCleaner.clean
      Item.create(title: 'Test Item',
                  description: 'description',
                  price: 1,
                  image: 'link')
      Merchant.create(name: 'Test Merchant')
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe '/merchants path' do
      it 'should navigate to merchants index' do
        visit '/merchants'

        expect(page).to have_content 'Test Merchant'
      end
    end

    describe '/items path' do
      it 'should navigate to items index' do
        visit '/items'

        expect(page).to have_content 'Test Item'
      end
    end
  end
end
