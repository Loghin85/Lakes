# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# NAME,AREA,DISTRCT,LAT,LONG,RIVER,DETAILS_URL,ALTITUDE,ALKALINITY,DEPTH
# Name	Area	District	Lat	Long	River	Details url	Altitude	Alkalinity	Depth	

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'sepa_loch_waterbody_classifications_bng.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = LakeDest.new
  t.Name = row['NAME']
  t.Area = row['AREA']
  t.District = row['DISTRCT']
  t.Lat = row['LAT']
  t.Long = row['LONG']
  t.River = row['RIVER']
  t.Details_Url = row['DETAILS_URL']
  t.Altitude = row['ALTITUDE']
  t.Alkalinity = row['ALKALINITY']
  t.Depth = row['DEPTH']
  t.save
  puts "#{t.Name} saved"
end