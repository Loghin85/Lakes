json.extract! booking, :id, :UserId, :NoOfPersons, :TripId, :Date, :Price, :created_at, :updated_at
json.url booking_url(booking, format: :json)
