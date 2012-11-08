# This file renders both people and groups (and OUs, which are a special form of groups)

object @entity

attributes :id, :name

node :type do |e|
  e.type.downcase
end

if @entity.type == "Person"
  attributes :first, :last, :email, :phone, :address, :loginid

  child @entity.roles do |role|
    attributes :id, :token, :descriptor, :description, :application_name
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
