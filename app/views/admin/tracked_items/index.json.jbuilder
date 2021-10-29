json.cache! ['admin_tracked_items_index', @cache_key] do
  json.tracked_items do
    json.array!(@tracked_items) do |tracked_item|
      json.extract! tracked_item, :id, :kind, :item_id
    end
  end

  json.departments do
    json.array!(@departments) do |department|
      json.extract! department, :id, :officialName, :code

      # Alias
      json.name department.officialName
    end
  end

  json.majors do
    json.array!(@majors) do |major|
      json.extract! major, :id, :name, :gr_code
    end
  end
end
