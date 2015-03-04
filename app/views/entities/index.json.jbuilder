# It is valid to have inactive entities here. The sidebar search needs to
# show users that an individual they may be searching for _is_ in the
# database but not available for use.
json.array!(@entities) do |entity|
  json.extract! entity, :id, :name, :type, :first, :loginid, :active
end
