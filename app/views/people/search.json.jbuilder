json.array!(@results) do |result|
  json.extract! result, :name, :loginid, :email, :imported
end
