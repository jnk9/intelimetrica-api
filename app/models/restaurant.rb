class Restaurant < ApplicationRecord
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :lat,
                   lng_column_name: :lng

  def self.allowed_attributes_create
    %i[rating name site email phone street city state lat lng]
  end

  def self.allowed_attributes_update
    %i[rating name site email phone street city state lat lng]
  end
end