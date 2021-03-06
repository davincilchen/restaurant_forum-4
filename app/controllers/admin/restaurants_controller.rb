class Admin::RestaurantsController < ApplicationController
before_action :authenticate_user!
before_action :authenticate_admin
before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "Restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "Restaurant was dailed to create"
      render :new
    end  
  end
 
  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurants_path(@restaurant)
      flash[:notice] = "Restaurant was successfully updated"
    else
      flash.now[:alert] = "Restaurant was failed to update"
      render :edit
    end  
  end 

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "餐廳已刪除"
  end 
    
private  

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :descrition, :image, :category_id ) 
  end  

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end  

end

