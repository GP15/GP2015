json.array!(@partners) do |partner|
  json.lat partner.latitude
  json.lng partner.longitude
end