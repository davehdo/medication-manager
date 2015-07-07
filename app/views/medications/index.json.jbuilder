json.array!(@medications) do |medication|
  json.extract! medication, :id, :name, :dose, :frequency
  json.url medication_url(medication, format: :json)
end
