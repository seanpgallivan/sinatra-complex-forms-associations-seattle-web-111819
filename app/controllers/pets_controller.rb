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
    if params[:owner_name].empty?
      @pet.update(name: params[:pet_name], owner_id: params[:owner_id])
    else
      @owner = Owner.create(name: params[:owner_name])
      @pet.update(name: params[:pet_name], owner_id: @owner.id)
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end