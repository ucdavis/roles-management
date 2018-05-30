require 'rake'

namespace :activity_logs do
  desc 'Upload plain-text activity logs to AWS DynamoDB'
  task :upload_from_files => :environment do
    require 'securerandom'

    entries_found = 0

    # Read existing log files
    total_files = Dir.entries(Rails.root.join('log', 'activity')).length
    files_read = 0
    Dir.foreach(Rails.root.join('log', 'activity')) do |item|
      next if item == '.' || item == '..' # skip current and parent directory entries
      filename = Rails.root.join('log', 'activity', item)
      files_read += 1
      puts "#{files_read} / #{total_files} (#{((files_read.to_f / total_files.to_f) * 100.0).round(2)} %) - #{filename}"
      File.open(filename, 'r') do |f|
        found_timestamps = {}
        f.each_line do |line|
          next if line[0] == '#' # skip comments
          timestamp = Time.parse(line[0..24]).to_f
          # Cut off timestamp
          line = line[28..-1]
          idx = line.index('-')
          log_level_str = line[0..idx-2]
          message = line[idx+2..-1].strip
          tag = item

          entries_found += 1

          begin
            DynamoDbClient.put_item(
              table_name: DynamoDbTable,
              item: {
                LogEntityId: tag,
                UUID: SecureRandom.uuid,
                entry: {
                  logged_at: timestamp,
                  level: log_level_str,
                  message: message
                }
              }
            )
          rescue Aws::DynamoDB::Errors::ServiceError => error
            Rails.logger.error 'Unable to write to DynamoDB activity log:'
            Rails.logger.error error.message.to_s
          end
        end
      end
    end

    puts "Total log entries found: #{entries_found}"
  end
end
