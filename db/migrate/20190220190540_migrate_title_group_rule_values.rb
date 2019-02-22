class MigrateTitleGroupRuleValues < ActiveRecord::Migration[5.2]
  def up
    GroupRule.where(column: 'title').each do |gr|
      title = Title.find_by(name: gr.value)
      unless title.present?
        puts "Unable to find title with name '#{gr.value}'. Ignoring ..."
        next
      end
      gr.value = title.code
      gr.save!
    end

    GroupRuleResultSet.where(column: 'title').each do |grrs|
      title = Title.find_by(name: grrs.value)
      unless title.present?
        puts "Unable to find title with name '#{grrs.value}'. Ignoring ..."
        next
      end
      grrs.value = title.code
      grrs.save!(validate: false) # grrs.value is validated to be immutable.
    end
  end

  def down
    STDERR.puts 'Migration is destructive and therefore irreversible.'
  end
end
