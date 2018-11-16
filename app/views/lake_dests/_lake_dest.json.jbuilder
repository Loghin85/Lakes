json.extract! lake_dest, :id, :Name, :Area, :District, :Lat, :Long, :River, :Details_Url, :Altitude, :Alkalinity, :Depth, :created_at, :updated_at
json.url lake_dest_url(lake_dest, format: :json)
