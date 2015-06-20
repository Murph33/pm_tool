class FavouritesController < ApplicationController

  def index
    
  end

  def create
    project = Project.find_by_id(params[:project_id])
    favourite = current_user.favourites.new
    favourite.project = project
    if favourite.save
     redirect_to project, notice: "Favourited!"
    else
     redirect_to project, alert: "Something went wrong"
    end
  end

  def destroy
    project = Project.find(params[:project_id])
    project.favourite_for(current_user).destroy
    redirect_to project, notice: "UnFavourited"
  end
end
