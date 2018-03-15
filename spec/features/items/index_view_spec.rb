RSpec.describe './app/views/items/index.erb', type: :feature do

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

  describe 'Item Index View' do
    describe 'An item\'s links' do
      it 'should navigate to item page when title is clicked' do
        visit '/items'
        click_link 'Test Item'

        expect(current_path).to eq '/items/1'
        expect(page).to have_content 'Test Item'
      end
    end
  end

  describe 'Item Show View' do
    describe 'Item Layout' do
      it 'should have an item title' do
        visit '/items/1'

        # expect(page).to have
      end
    end
  end
end
