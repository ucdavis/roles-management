object @entity
#cache ['entity_show', @entity]

attributes :name, :type

# child :group_memberships do |membership|
#   attributes :group_id, :id
#   glue(:group) {
#     attribute :name
#   }
# end
# 
# child :group_ownerships do |ownership|
#   attributes :id, :group_id
#   
#   glue(:group) { attribute :name }
# end
# 
# child :group_operatorships do
#   attributes :id, :group_id
#   
#   glue(:group) { attribute :name }
# end
# 
# child :role_assignments do
#   attributes :id, :role_id
#   
#   glue(:role) {
#     attributes :name, :token, :application_id
#     glue(:application) { attribute :name => :application_name }
#   }
# end
