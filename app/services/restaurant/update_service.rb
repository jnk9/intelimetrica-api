class Restaurant::UpdateService < Aldous::Service
  attr_reader :restaurant

  def initialize(id, params = {})
    @id = id
    @params = params
  end

  def default_result_data
    { restaurant: nil }
  end

  def raisable_error
    Aldous::Errors::RestaurantError
  end

  def perform
    find_restaurant
    if @restaurant.update_attributes(@params)
      Result::Success.new(restaurant: @restaurant)
    else 
      Result::Failure.new(restaurant: @restaurant)
    end
  rescue => e
    Result::Failure.new(restaurant: @restaurant)
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(@id)
    Result::Failure.new(restaurant: @restaurant) unless @restaurant
  rescue => e
    Result::Failure.new(restaurant: @restaurant)
  end
end