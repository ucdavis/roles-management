collection @entities
cache ['entities_index', Digest::MD5.hexdigest(@entities.map(&:cache_key).to_s)]

@entities.each do |entity|
  if entity.status
    attributes :id, :loginid, :name, :type #, :if => lambda { |e| e.status == true }
  end
end
