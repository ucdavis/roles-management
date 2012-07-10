# The following are common functions useful when working with UIDs.
# See the README for an explanation of UIDs.
# Note: Named 'Uids' instead of UIDs for easier loading in Ruby.
module Uids
  # 'uids' is a list of UIDs
  # Set flatten to true if you want group membership resolved so the list is only Person objects
  def resolve_uids(uids, flatten = false)
    if flatten
      results = []
    else
      results = {}
      results[:people] = []
      results[:groups] = []
    end

    uids.each do |uid|
      id = uid[1..-1]
      if uid[0] == '1'
        p = Person.find_by_id(id)
        if p
          if flatten
            results << p
          else
            results[:people] << p
          end
        end
      elsif uid[0] == '2'
        g = Group.find_by_id(id)
        if g
          if flatten
            g.members.each do |m|
              results << m
            end
          else
            results[:groups] << g
          end
        end
      end
    end

    results
  end

  # Returns an array containing the UID integer and ID separated
  def determine_uid(uid)
    uid = uid.to_s # ensure it's a string
    ret = {}
    ret[:type] = uid[0].to_i
    ret[:id] = uid[1..-1].to_i
    ret
  end
end
