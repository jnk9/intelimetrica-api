class Restaurant::CreateService < Aldous::Service
  attr_reader :restaurant

  def initialize(params = {})
    @params = params
  end

  def default_result_data
    { restaurant: nil }
  end

  def raisable_error
    Aldous::Errors::RestaurantError
  end

  def perform
    Restaurant.transaction do
      @restaurant = Restaurant.new(@params)
      
      if @restaurant.save
        Result::Success.new(restaurant: @restaurant)
      else
        Result::Failure.new(restaurant: @restaurant)
      end
    end
  rescue => e
    Result::Failure.new(message: e)
  end
end