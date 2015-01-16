# BreakoutLogger "breaks out" certain types of logging into other files.
# This is useful to avoid cluttering production.log with common requests
# which may deserve a separate log file, e.g. "/status.json" up-time checks
# or "/api/unimportant.json" API requests.
#
# Adapted from: http://dennisreimann.de/blog/silencing-the-rails-log-on-a-per-action-basis/

class BreakoutLogger < Rails::Rack::Logger
  def initialize(app, opts = {})
    @app = app
    @silence = opts[:silence]
    @breakout = opts[:breakout]

    # Delete these two keys to avoid TaggedLogger from misinterpreting them
    opts.delete(:silence)
    opts.delete(:breakout)

    super
  end

  def call(env)
    if @silence.include?(env['PATH_INFO'])
      # Set the Rails log level inappropriately high as
      # Rails.logger.silenced is deprecated.
      old_level = Rails.logger.level
      Rails.logger.level = 7

      ret = @app.call(env)

      Rails.logger.level = old_level

      return ret
    else
      @breakout.each do |breakout_opt|
        if env['PATH_INFO'].match(breakout_opt[0])
          # Swap out the Rails logger(s) for a custom one.
          backup_loggers = []
          backup_loggers[0] = Rails.logger
          backup_loggers[1] = ActiveRecord::Base.logger
          backup_loggers[2] = ActionController::Base.logger

          Rails.logger = ActiveRecord::Base.logger = ActionController::Base.logger = ActiveSupport::TaggedLogging.new(Logger.new("#{Rails.root.join('log', breakout_opt[1])}"))
          ret = @app.call(env)

          # How embarrassing ...
          Rails.logger = backup_loggers[0]
          ActiveRecord::Base.logger = backup_loggers[1]
          ActionController::Base.logger = backup_loggers[2]

          return ret
        end
      end

      # Only called if @silence and @breakout don't match
      super(env)
    end
  end
end
