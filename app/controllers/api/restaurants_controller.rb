require 'descriptive_statistics'
class Api::RestaurantsController < ApplicationController
  before_action :restaurants_all, only: [:index]
  before_action :find_restaurant, only: [:show]

  def index
    render json: @restaurants
  end

  def show
    render json: @restaurant
  end

  def create
    create_service =Restaurant::CreateService.new(restaurant_create_params)
    result = create_service.perform
    @restaurant = result.restaurant

    if result.success?
      render json: {restaurant: @restaurant}
    else
      render json: { message: @restaurant.errors }, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def update
    update_service =Restaurant::UpdateService.new(params[:id], restaurant_update_params)
    result = update_service.perform

    @restaurant = result.restaurant

    if result.success?
      render json: @restaurant
    else
      render json: {message: result._data}, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def destroy
    destroy_service = Restaurant::DestroyService.new(params[:id])
    result = destroy_service.perform

    if result.success?
      render json: { message: 'Restaurant deleted successfully'}
    else
      render json: {state: :error, message: result._data}, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def statistics
    statistics = Restaurant.within(params[:radius].to_i.meters.to.kilometers.value, :origin => [params[:latitude], params[:longitude]])
    ratings = statistics.pluck(:rating)

    render json: {
      count: ratings.number,
      avg: ratings.mean,
      std: ratings.standard_deviation,
      mode: ratings.mode,
      min: ratings.min,
      max: ratings.max
    }
  end

  private

  def restaurant_create_params
    params.require(:restaurant).permit(Restaurant.allowed_attributes_create)
  end

  def restaurant_update_params
    params.require(:restaurant).permit(Restaurant.allowed_attributes_update)
  end

  def restaurants_all
    @restaurants = Restaurant.all
  end

  def find_restaurant
    @restaurant = restaurants_all.find_by_id(params[:id])
  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end
end