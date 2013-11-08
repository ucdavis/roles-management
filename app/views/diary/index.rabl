object @entries
cache ['diary_index', @entries]

attributes :created_at, :diary_uid_id

glue(:context) {
  attribute :display_name
}
