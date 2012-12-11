# This file renders both people and groups (and OUs, a special form of group)

object @entity

attributes :id, :name, :type

if @entity.type == "Person"
  attributes :first, :last, :email, :phone, :address, :loginid

  child @entity.roles => :roles do
    attributes :id, :token, :descriptor, :description, :application_name
  end

  child @entity.favorites => :favorites do
    attributes :id, :name, :type
  end

  child @entity.groups.non_ous => :groups do
    attributes :id, :name
  end

  child @entity.groups.ous => :ous do
    attributes :id, :name
  end

  child @entity.group_ownerships => :group_ownerships do
    attributes :id, :name
  end

  child @entity.group_operatorships => :group_operatorships do
    attributes :id, :name
  end
end

if ((defined? @entity.members) != nil)
  child @entity.members => :members do
    attributes :id, :loginid, :name
  end
end

if ((defined? @entity.owners) != nil)
  child @entity.owners => :owners do
    attributes :id, :loginid, :name
  end
end

if ((defined? @entity.operators) != nil)
  child @entity.operators => :operators do
    attributes :id, :loginid, :name
  end
end

if ((defined? @entity.rules) != nil)
  child @entity.rules => :rules do
    attributes :id, :column, :condition, :value
  end
end
