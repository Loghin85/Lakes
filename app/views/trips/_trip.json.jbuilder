json.extract! trip, :id, :Name, :Lakes, :Date, :Price, :AvailablePlaces, :created_at, :updated_at
json.url trip_url(trip, format: :json)
