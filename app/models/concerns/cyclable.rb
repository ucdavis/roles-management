# Module to help detect cycles in child/parent relationships
module Cyclable
  extend ActiveSupport::Concern

  class CycleDetectedError < StandardError
  end

  included do
    #validate :contains_no_cycles
    
    #private
    
    def detect_cycles(parents_method, children_method)
      ids_seen = [self.id]
      
      ## CAREFUL, wouldn't this check the graph way too many times if it's recursively-repeating the parent/children checks?
      
      # Check for cycles in parents
      self.send(parents_method).each do |parent|
        raise CycleDetectedError if ids_seen.include? parent.id
        ids_seen << parent.id
        parent.detect_cycles(parents_method, children_method)
      end
      
      # Check for cycles in children
      self.send(children_method).each do |child|
        raise CycleDetectedError if ids_seen.include? child.id
        ids_seen << child.id
        child.detect_cycles(parents_method, children_method)
      end
      
      
      # self.changes.each do |key, value_delta|
      #   if key == 'updated_at'
      #     #DiaryEntry.write! diary_uid_id, "Marked as updated"
      #   else
      #     begin
      #       # Allow them to define a 'diary_X' function to rescribe the diary entry if they wish.
      #       # Expected to return a string.
      #       message = send(('diary_' + key).to_sym)
      #       DiaryEntry.write! diary_uid_id, message if message
      #     rescue NoMethodError
      #       DiaryEntry.write! diary_uid_id, "Attribute '#{key}' changed from '#{value_delta[0]}' to '#{value_delta[1]}'"
      #     end
      #   end
      # end
    end
  end

  # def diary(entry)
  #   DiaryEntry.write! diary_uid_id, entry
  # end
  # 
  # def diary_uid_id
  #   @_diary_uid_id ||= DiaryUid.find_or_create_by_reference_and_display_name(diary_uid, diary_display_name).id
  # end
  # 
  # def diary_uid
  #   self.class.name.to_s + "-" + self.id.to_s
  # end
  # 
  # def diary_display_name
  #   self.name or diary_uid
  # end
end
