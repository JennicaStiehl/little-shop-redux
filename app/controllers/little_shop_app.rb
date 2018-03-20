# Defines LittleShop
class LittleShopApp < Sinatra::Base
  set :public_folder, 'public'

  get '/items' do
    erb :'items/index', locals: { items: Item.all }
  end

  get '/items/new' do
    erb :'items/new', locals: { merchants: Merchant.all }
  end

  post '/items' do
    Item.create(params[:item])

    redirect '/items'
  end

  delete '/items/:id' do
    Item.destroy(params[:id])

    redirect '/items'
  end

  get '/items/:id' do
    erb :'items/show', locals: { item: Item.find(params[:id]) }
  end

  get '/items/:id/edit' do
    erb :'items/edit', locals: { item: Item.find(params[:id]) }
  end

  put '/items/:id' do
    Item.update(params[:item])

    redirect '/items/:id'
  end

  get '/items-dashboard' do
    erb :'items/dashboard'
  end

  get '/merchants' do
    erb :'merchants/index',
        locals: { merchants: Merchant.all },
        layout: :list_layout
  end

  get '/merchants/new' do
    erb :'merchants/new'
  end

  post '/merchants' do
    Merchant.create(params[:item])

    redirect '/merchants'
  end

  delete '/merchants/:id' do
    Merchant.destroy(params[:id])

    redirect '/merchants'
  end

  get '/merchants/:id' do
    erb :'merchants/show', locals: { merchant: Merchant.find(params[:id]) }
  end

  get '/merchants/:id/edit' do
    erb :'merchants/edit', locals: { merchant: Merchant.find(params[:id]) }
  end

  put '/merchants/:id' do
    Merchant.update(params[:merchant])

    redirect '/merchants/:id'
  end

  get '/merchants-dashboard' do
    erb :'merchants/dashboard'
  end

  get '/invoices' do
    erb :'invoices/index',
        locals: { invoices: Invoice.all },
        layout: :list_layout
  end

  get '/invoices/new' do
    erb :'invoices/new', locals: { merchants: Invoice.merchants }
  end

  post '/invoices' do
    Invoice.create(params[:invoice])

    redirect '/invoices'
  end

  delete '/invoices/:id' do
    Invoice.destroy(params[:id])

    redirect '/invoices'
  end

  get '/invoices/:id' do
    erb :'invoices/show', locals: { invoice: Invoice.find(params[:id]) }
  end

  get '/invoices/:id/edit' do
    erb :'invoices/edit', locals: { invoice: Invoice.find(params[:id]) }
  end

  put '/invoices/:id' do
    Invoice.update(params[:invoice])

    redirect '/invoices/:id'
  end

  get '/invoices-dashboard' do
    erb :'invoices/dashboard'
  end
end
