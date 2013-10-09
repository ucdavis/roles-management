collection @entities
cache ['entities_index', Digest::MD5.hexdigest(@entities.map(&:cache_key).to_s)]

attributes :id, :loginid, :name, :type
