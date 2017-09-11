# Usage:
# ruby test.rb TW9
# ruby test.rb TW9 2AD

require 'csv'

unless ARGV[0]
  raise StandardError.new("Please provide a postcode.")
end

STATUS_MAP = { 
    "F" => "Freehold",
    "L" => "Leasehold"
  }

postcode = ARGV[0]
if ARGV[1]
  postcode += " " + ARGV[1]
end 

data = CSV.read("./house_data.csv")
props = []

data.each do |row|
  if row[3].include?(postcode)
    props << row
  end
end; nil

mapped = []

props.each do |p|
  mapped << { 
              price: p[1].to_i,
              date: p[2][0..9],
              postcode: p[3],
              hold_status: STATUS_MAP[ p[6] ],
              address: [ p[7], p[8], p[9], p[10], p[11], p[12], p[3] ].reject(&:empty?).join(", ")
            }
end

mapped.map! do |record|
  if record[:price] < 500000
    record
  end 
end

puts mapped

# For each address get:
  # number_of_beds
  # Link to Rightmove or Zoopla
  # Zoopla estimate
  # Rightmove estimate

# mapped.each do |prop_hash|
  # prop_hash[:address]
# end









