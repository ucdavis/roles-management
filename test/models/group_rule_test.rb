require 'test_helper'

class GroupRuleTest < ActiveSupport::TestCase
  setup do
    fake_cas_login

    @person = entities(:casuser)
  end

  test 'changing relevant person attributes should automatically associate them with the proper groups' do
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.empty?, 'looks like groupWithNothing has a role'
    assert group.rules.empty?, 'looks like groupWithNothing has a rule'
    assert group.owners.empty?, 'looks like groupWithNothing has an owner'
    assert group.operators.empty?, 'looks like groupWithNothing has an operator'

    # Test login ID rules
    assert group.members.empty?, 'group should have no members'

    GroupRulesService.add_group_rule(group, 'loginid', 'is', 'casuser2')

    group.reload

    assert group.members.empty?, 'group should have no members'

    @person.loginid = 'casuser2'
    @person.save!

    group.reload

    assert group.members.length == 1, 'group should have a member'

    @person.loginid = 'casuser'
    @person.save!

    group.reload

    assert group.members.empty?, 'group should have no members'

    group_rule = group.rules[0]
    group_rule.value = 'casuser'
    group_rule.save!

    group.reload

    assert group.members.length == 1, 'group should have a member'

    # Test that destroying all rules removes members
    group.rules.destroy_all

    group.reload

    assert group.members.empty?, 'group should have no members'

    # Test that setting a person's title fills in a group
    GroupRulesService.add_group_rule(group, 'title', 'is', 'Researcher')

    group.reload

    assert group.members.empty?, 'group should have no members'

    # Test that setting a person's major fills in a group
    group.rules.destroy_all
    GroupRulesService.add_group_rule(group, 'major', 'is', 'History')

    group.reload

    assert group.members.empty?, 'group should have no members'
  end

  test 'creating a person should associate them with the proper groups' do
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.empty?, 'looks like groupWithNothing has a role'
    assert group.rules.empty?, 'looks like groupWithNothing has a rule'
    assert group.owners.empty?, 'looks like groupWithNothing has an owner'
    assert group.operators.empty?, 'looks like groupWithNothing has an operator'

    # Test login ID rules
    assert group.members.empty?, 'group should have no members'

    GroupRulesService.add_group_rule(group, 'loginid', 'is', 'somebody_new')

    group.reload

    assert group.members.empty?, 'group should have no members'

    person = Person.new(loginid: 'somebody_new', first: 'Somebody', last: 'New')
    person.save!

    group.reload

    assert group.members.length == 1, 'group should have a member'
  end

  test 'deleting a person or disabling them should disassociate them with the proper groups' do
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.empty?, "looks like groupWithNothing has a role"
    assert group.rules.empty?, "looks like groupWithNothing has a rule"
    assert group.owners.empty?, "looks like groupWithNothing has an owner"
    assert group.operators.empty?, "looks like groupWithNothing has an operator"

    # Test login ID rules
    assert group.members.empty?, 'group should have no members'

    GroupRulesService.add_group_rule(group, 'loginid', 'is', 'cthielen')

    group.reload

    assert group.members.length == 1, 'group should have a member'

    person = entities(:cthielen)
    person.destroy

    group.reload

    assert group.members.empty?, 'group should have no members'
  end

  test 'group rules are ANDed together correctly' do
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.empty?, 'looks like groupWithNothing has a role'
    assert group.rules.empty?, 'looks like groupWithNothing has a rule'
    assert group.owners.empty?, 'looks like groupWithNothing has an owner'
    assert group.operators.empty?, 'looks like groupWithNothing has an operator'

    title = titles(:programmer)
    department = departments(:dssit)

    PpsAssociationsService.remove_all_pps_associations_from_person(@person)
    @person.reload
    assert @person.pps_associations.count.zero?

    PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)

    @person.reload
    assert @person.pps_associations.length == 1
    assert @person.pps_associations[0].department.present?
    assert @person.pps_associations[0].department.code == '040014', 'Expected dept code to be 040014'

    # Test login ID rules
    assert group.members.empty?, 'group should have no members'

    GroupRulesService.add_group_rule(group, 'department', 'is', '040014')

    group.reload

    assert group.members.length == 1, 'group should have a member'

    GroupRulesService.add_group_rule(group, 'title', 'is', 'something that does not exist')

    group.reload

    assert group.members.empty?, 'group should have no members'
  end

  test "Rule 'login ID is not' works" do
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.empty?, 'looks like groupWithNothing has a role'
    assert group.rules.empty?, 'looks like groupWithNothing has a rule'
    assert group.owners.empty?, 'looks like groupWithNothing has an owner'
    assert group.operators.empty?, 'looks like groupWithNothing has an operator'

    # Give person a PPS association so we can match them, then ensure 'login is not' works
    title = titles(:programmer)
    department = departments(:dssit)

    PpsAssociationsService.remove_all_pps_associations_from_person(@person)
    @person.reload
    assert @person.pps_associations.count.zero?
    PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
    @person.reload
    assert @person.pps_associations.length == 1

    # Test login ID rules
    assert group.members.empty?, 'group should have no members'

    GroupRulesService.add_group_rule(group, 'title', 'is', titles(:programmer).code)

    group.reload

    assert group.members.length == 1, 'group should have a member'

    GroupRulesService.add_group_rule(group, 'loginid', 'is not', @person.loginid)

    group.reload

    assert group.members.empty?, 'group should have no members'
  end

  test "Rule 'is_staff' works" do
    setup_match = lambda {
      @person.is_staff = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_staff = false
      @person.save!
    }

    test_group_rule('is_staff', 'is', true, setup_match, remove_match)
  end

  test "Rule 'is_faculty' works" do
    setup_match = lambda {
      @person.is_faculty = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_faculty = false
      @person.save!
    }

    test_group_rule('is_faculty', 'is', true, setup_match, remove_match)
  end

  test "Rule 'is_student' works" do
    setup_match = lambda {
      @person.is_student = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_student = false
      @person.save!
    }

    test_group_rule('is_student', 'is', true, setup_match, remove_match)
  end

  test "Rule 'is_employee' works" do
    setup_match = lambda {
      @person.is_employee = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_employee = false
      @person.save!
    }

    test_group_rule('is_employee', 'is', true, setup_match, remove_match)
  end

  test "Rule 'is_hs_employee' works" do
    setup_match = lambda {
      @person.is_hs_employee = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_hs_employee = false
      @person.save!
    }

    test_group_rule('is_hs_employee', 'is', true, setup_match, remove_match)
  end

  test "Rule 'is_external' works" do
    setup_match = lambda {
      @person.is_external = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_external = false
      @person.save!
    }

    test_group_rule('is_external', 'is', true, setup_match, remove_match)
  end

  test "Rule 'title is' works" do
    setup_match = lambda {
      # Give a person an association involving a title with a 99-unit
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
      @person.reload
      assert @person.pps_associations.length == 1
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule('title', 'is', titles(:programmer).code, setup_match, remove_match)
  end

  test "Rule 'sis_level_code' works" do
    setup_match = lambda {
      # Give a person a SIS association with level code 'GR'
      SisAssociationsService.add_sis_association_to_person(@person, Major.first, 1, 'GR')
    }

    remove_match = lambda {
      SisAssociationsService.remove_sis_association_from_person(@person, @person.sis_associations[0])
    }

    test_group_rule('sis_level_code', 'is', 'GR', setup_match, remove_match)
  end

  test "Rule 'major' works" do
    setup_match = lambda {
      # Give a person a SIS association with level code 'GR'
      SisAssociationsService.add_sis_association_to_person(@person, Major.find_by(name: 'History'), 1, 'GR')
    }

    remove_match = lambda {
      SisAssociationsService.remove_sis_association_from_person(@person, @person.sis_associations[0])
    }

    test_group_rule('major', 'is', 'History', setup_match, remove_match)
  end

  test "Rule 'pps_unit' works" do
    setup_match = lambda {
      # Give a person an association involving a title with a 99-unit
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule('pps_unit', 'is', '99', setup_match, remove_match)
  end

  test "Rule 'pps_position_type' works" do
    setup_match = lambda {
      # Give a person an association involving a title with a 99-unit
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule('pps_position_type', 'is', 2, setup_match, remove_match)
  end

  test "Rule 'business_office_unit' works" do
    evil_person = entities(:evil_casuser)

    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
      @person.reload

      evil_title = titles(:evil_programmer)
      evil_department = departments(:evil_dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(evil_person)
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(evil_person, evil_title, evil_department, department, department, 1, 2, 1)
      evil_person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?

      assert evil_person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(evil_person, evil_person.pps_associations[0])
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
    }

    test_group_rule('business_office_unit', 'is', 'F80B657C9EE823A0E0340003BA8A560D', setup_match, remove_match, 2)
  end

  test "Rule 'admin_business_office_unit' works" do
    evil_person = entities(:evil_casuser)

    setup_match = lambda {
      # Put two people in the same department with different admin department BOUs
      title = titles(:programmer)
      department = departments(:dssit)
      admin_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
      @person.reload

      evil_title = titles(:evil_programmer)

      PpsAssociationsService.remove_all_pps_associations_from_person(evil_person)
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(evil_person, evil_title, department, admin_department, department, 1, 2, 1)
      evil_person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?

      assert evil_person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(evil_person, evil_person.pps_associations[0])
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
    }

    test_group_rule('admin_business_office_unit', 'is', 'B80B657C6EE823A0E0340003BA8A560D', setup_match, remove_match)
  end

  test "Rule 'appt_business_office_unit' works" do
    evil_person = entities(:evil_casuser)

    setup_match = lambda {
      # Put two people in the same department with different admin department BOUs
      title = titles(:programmer)
      department = departments(:dssit)
      appt_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, appt_department, 1, 2, 1)
      @person.reload

      evil_title = titles(:evil_programmer)

      PpsAssociationsService.remove_all_pps_associations_from_person(evil_person)
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(evil_person, evil_title, department, department, department, 1, 2, 1)
      evil_person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?

      assert evil_person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(evil_person, evil_person.pps_associations[0])
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
    }

    test_group_rule('appt_business_office_unit', 'is', 'B80B657C6EE823A0E0340003BA8A560D', setup_match, remove_match)
  end

  test "Rule 'department' works" do
    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule('department', 'is', '040014', setup_match, remove_match)
  end

  test "Rule 'admin department' works" do
    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)
      asucd_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, asucd_department, department, 1, 2, 1)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule('admin_department', 'is', '410041', setup_match, remove_match)
  end

  test "Rule 'appt department' works" do
    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)
      asucd_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, asucd_department, 1, 2, 1)
      @person.reload
      assert @person.pps_associations.count == 1
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule('appt_department', 'is', '410041', setup_match, remove_match)
  end

  test "Rule 'employee_class' works" do
    setup_match = lambda {
      # Give a person an association involving an employee class of 1
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2, 1)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule('employee_class', 'is', 1, setup_match, remove_match)
  end

  private

  # Generic function for testing a group rule. Tests:
  #  1. A new rule matches existing data
  #  2. Alters data to remove match against existing rule
  #  3. Alters data to add match against existing rule
  #
  # group_rule   - an unsaved GroupRule object to be tested
  # setup_match  - should alter data to ensure group_rule will have a match
  # remove_match - should alter data to ensure group_rule will not have a match
  #
  # Test assumes only one match will happen whenever a match is expected.
  def test_group_rule(column, condition, value, setup_match, remove_match, expected_member_count = 1)
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.empty?, 'looks like groupWithNothing has a role'
    assert group.rules.empty?, 'looks like groupWithNothing has a rule'
    assert group.owners.empty?, 'looks like groupWithNothing has an owner'
    assert group.operators.empty?, 'looks like groupWithNothing has an operator'

    Rails.logger.tagged 'test_group_rule' do
      Rails.logger.debug 'Calling setup ...'

      setup_match.call()

      # Test basic rule creation matches existing people
      assert group.members.empty?, 'group should have no members'

      Rails.logger.debug 'Adding group rule ...'
      GroupRulesService.add_group_rule(group, column, condition, value)

      group.reload
      # Subtract a second from the 'updated_at' flag to ensure it is a reliable
      # indicator of a group being touched
      group.updated_at -= 1
      group.save!
      group_last_updated_at = group.updated_at

      assert group.members.length == expected_member_count, "group should have #{expected_member_count} member(s) but has #{group.members.length} member(s)"

      Rails.logger.debug 'Calling remove ...'
      remove_match.call()

      Rails.logger.debug 'Checking that group has no members ...'
      group.reload
      assert group.updated_at > group_last_updated_at, 'group should have been touched'

      # Subtract a second from the 'updated_at' flag to ensure it is a reliable
      # indicator of a group being touched
      group.updated_at -= 1
      group.save!
      group_last_updated_at = group.updated_at
      assert group.members.empty?, "group should have no members but has #{group.members.count}"

      Rails.logger.debug 'Calling setup again ...'
      setup_match.call()

      group.reload
      assert group.updated_at > group_last_updated_at, 'group should have been touched'
      group_last_updated_at = group.updated_at

      assert group.members.length == expected_member_count, "group should have #{expected_member_count} member(s)"
    end
  end
end
