
require 'csv'

csv_text = File.read('lib/files/restaurantes.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  new_hash = row.to_hash
  new_hash.delete('id')
  Restaurant.create!(new_hash)
end