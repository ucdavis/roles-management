namespace :activity_logs do
  desc 'Convert DB-based ActivityLogs to file'
  task convert: :environment do
    ActivityLogTag.all.each do |tag|
      logger = Logger.new(Rails.root.join('log', 'activity').to_s + '/' + tag.tag)
      logger.formatter = proc do |_severity, _datetime, _progname, msg|
        "#{msg}\n"
      end

      tag.activity_logs.order('performed_at ASC').each do |log|
        log_level_str = 'INFO' if log.level == 0 # rubocop:disable Style/NumericPredicate
        log_level_str = 'WARN' if log.level == 1
        log_level_str = 'ERROR' if log.level == 2
        logger.info "#{log.performed_at} - #{log_level_str} - #{log.message}"
      end

      tag.destroy

      logger.close
    end

    ActivityLogTagAssociation.destroy_all
    ActivityLog.destroy_all
  end
end
