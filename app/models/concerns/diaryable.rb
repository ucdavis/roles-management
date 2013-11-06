# Not to be confused with logging, a diary is a human-readable account
# of events for a model. Designed to be used for logs read by system
# administrators and not developers.
module Diaryable
  extend ActiveSupport::Concern

  included do
    after_save :diaryable_write_changes_in_diary

    private

    def diaryable_write_changes_in_diary
      self.changes.each do |key, value_delta|
        if key == 'updated_at'
          #DiaryEntry.write! diary_uid_id, "Marked as updated"
        else
          DiaryEntry.write! diary_uid_id, "Attribute '#{key}' changed from '#{value_delta[0]}' to '#{value_delta[1]}'"
        end
      end
    end
  end

  def diary(entry)
    DiaryEntry.write! diary_uid_id, entry
  end

  def diary_uid_id
    @_diary_uid_id ||= DiaryUid.find_or_create_by_reference_and_display_name(diary_uid, diary_display_name).id
  end

  def diary_uid
    self.class.name.to_s + "-" + self.id.to_s
  end

  def diary_display_name
    self.name or diary_uid
  end
end
