class Restaurant::DestroyService < Aldous::Service
  attr_reader :restaurant

  def initialize(id)
    @id = id
  end

  def perform
    Restaurant.transaction do
      find_restaurant
      
      if @restaurant && @restaurant.destroy
        Result::Success.new(restaurant: @restaurant)
      else
        Result::Failure.new(message: find_restaurant.message)
      end
    end
  rescue => e
    Result::Failure.new(message: e)
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find_by_id(@id)
    Result::Failure.new(message: 'Restaurant not found') unless @restaurant
  rescue => e
    Result::Failure.new(restaurant: @restaurant, message: e)
  end
end