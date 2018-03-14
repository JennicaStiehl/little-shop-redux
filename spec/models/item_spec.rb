RSpec.describe Item do

  describe 'Validate fields' do
    it 'is invalid to not have a title' do
      item = Item.new(description: 'description',
                      price: 1,
                      image: 'link')
      expect(item).to_not be_valid
    end
    it 'is invalid to not have a description' do
      item = Item.new(title: '',
                      price: 1,
                      image: 'link')
      expect(item).to_not be_valid
    end
    it 'is invalid to not have a price' do
      item = Item.new(title: '',
                      description: 'description',
                      image: 'link')
      expect(item).to_not be_valid
    end
    it 'is invalid to not have an image' do
      item = Item.new(title: '',
                      description: 'description',
                      price: 1)
      expect(item).to_not be_valid
    end
  end
end
