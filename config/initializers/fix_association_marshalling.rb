module ActiveRecord
  module Associations
    class CollectionProxy
      def respond_to?(name, include_private = false)
        if super
          true
        elsif [:marshal_dump, :_dump].include?(name)
          false
        else
          (load_target && target.respond_to?(name, include_private)) ||
            proxy_association.klass.respond_to?(name, include_private)
        end
      end
    end
  end
end

