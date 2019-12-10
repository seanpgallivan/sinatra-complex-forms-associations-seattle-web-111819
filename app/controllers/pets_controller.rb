class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end
  
  post '/pets' do 
    @pet = Pet.create(name: params[:pet_name])
    if params[:owner_id]
      @pet.owner_id = params[:owner_id].to_i
    else
      @pet.owner_id = Owner.create(name: params[:owner_name]).id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params[:owner][:name].empty?
      params[:pet][:owner_id] = Owner.create(params[:owner]).id
    end
    @pet.update(params[:pet])
    redirect "pets/#{@pet.id}"
  end
end