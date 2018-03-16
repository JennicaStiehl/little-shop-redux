# Defines LittleShop
class LittleShopApp < Sinatra::Base
  set :public_folder, 'public'

  get '/merchants' do
    erb :"merchants/index", locals: { merchants: Merchant.all }
  end

  get '/items' do
    erb :'items/index', locals: { items: Item.all }
  end

  get '/items/:id' do
    erb :'items/show', locals: { item: Item.find(params[:id]) }
  end

  get '/items/new' do
    erb :'items/new.erb'
  end

  get '/items/:id/edit' do
    erb :'items/edit', locals: { item: Item.find(params[:id]) }
  end
end
