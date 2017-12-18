namespace :iam do # rubocop:disable Metrics/BlockLength
  require 'ucd_iam'
  include UcdIam

  desc 'Import SIS majors using IAM'
  task import_sis_majors: :environment do
    majors = UcdIam.fetch_sis_majors

    majors.each do |major|
      Major.find_or_create_by(name: major['majorName'])
    end
  end
end
