class Restaurant < ApplicationRecord

  def self.allowed_attributes_create
    %i[rating name site email phone street city state lat lng]
  end

  def self.allowed_attributes_update
    %i[rating name site email phone street city state lat lng]
  end
end