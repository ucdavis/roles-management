object @entries
cache ['diary_index', @entries]

# node :date do |e|
#   e.created_at.strftime('%Y/%m/%d %H:%M:%S %z')
# end

attributes :diary_uid_id => :uid, :created_at => :date

glue(:context) {
  attribute :display_name => :name
}
