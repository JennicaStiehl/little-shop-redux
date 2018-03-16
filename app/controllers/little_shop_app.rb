# Defines LittleShop
class LittleShopApp < Sinatra::Base
  set :public_folder, 'public'

  get '/merchants' do
    erb :"merchants/index", locals: { merchants: Merchant.all }
  end

  get '/items' do
    @items = Item.all
    erb :'items/index', layout: :index_layout
  end

  get '/items/:id' do
    @item = Item.find(params[:id])
    erb :'items/show'
  end

  get '/items/new' do
    erb :'items/new.erb'
  end

  get '/items/:id/edit' do
    erb :'items/edit', locals: { item: Item.find(params[:id]) }
  end
end
