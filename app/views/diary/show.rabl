object @uid
cache ['diary_show', @uid]

attribute :display_name => :name

child @uid.entries.order('created_at DESC') => :entries do
  attributes :created_at, :message
  # glue(:entity) {
  #   attributes :type, :name
  # }
  # node :calculated do |a|
  #   a.parent_id != nil
  # end
end
