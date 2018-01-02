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

  desc 'Import BOUs using IAM'
  task import_bous: :environment do
    bous = UcdIam.fetch_bous

    bous.each do |bou|
      b = BusinessOfficeUnit.find_or_create_by(org_oid: bou['orgOId'], dept_code: bou['deptCode'])

      b.dept_official_name = bou['deptOfficialName']
      b.dept_display_name = bou['deptDisplayName']
      b.dept_abbrev = bou['deptAbbrev']
      b.is_ucdhs = bou['isUCDHS']

      b.save! if b.changed?
    end
  end
end
