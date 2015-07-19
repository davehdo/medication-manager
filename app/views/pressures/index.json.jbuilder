json.array!(@pressures) do |pressure|
  json.extract! pressure, :id, :systolic, :diastolic, :taken_at
  json.url pressure_url(pressure, format: :json)
end
