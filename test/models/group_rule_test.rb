require 'test_helper'

class GroupRuleTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake('casuser')

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

    group_rule = GroupRule.new(column: 'loginid', condition: 'is', value: 'casuser2', group_id: group.id)
    group.rules << group_rule

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
    group_rule = GroupRule.new(column: 'title', condition: 'is', value: 'Researcher', group_id: group.id)
    group.rules << group_rule

    group.reload

    assert group.members.empty?, 'group should have no members'

    # Test that setting a person's major fills in a group
    group.rules.destroy_all
    group_rule = GroupRule.new(column: 'major', condition: 'is', value: 'History', group_id: group.id)
    group.rules << group_rule

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

    group_rule = GroupRule.new(column: 'loginid', condition: 'is', value: 'somebody_new', group_id: group.id)
    group.rules << group_rule

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

    group_rule = GroupRule.new( column: 'loginid', condition: 'is', value: 'cthielen', group_id: group.id )
    group.rules << group_rule

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

    PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
    
    @person.reload
    assert @person.pps_associations.length == 1
    assert @person.pps_associations[0].department.present?
    assert @person.pps_associations[0].department.code == '040014', 'Expected dept code to be 040014'

    # Test login ID rules
    assert group.members.empty?, 'group should have no members'

    group_rule = GroupRule.new(column: 'department', condition: 'is', value: '040014')
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, 'group should have a member'

    group_rule = GroupRule.new(column: 'title', condition: 'is', value: 'something that does not exist', group_id: group.id)
    group.rules << group_rule

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
    PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
    @person.reload
    assert @person.pps_associations.length == 1

    # Test login ID rules
    assert group.members.empty?, 'group should have no members'

    group_rule = GroupRule.new(column: 'title', condition: 'is', value: titles(:programmer).code, group_id: group.id)
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, 'group should have a member'

    group_rule = GroupRule.new(column: 'loginid', condition: 'is not', value: @person.loginid, group_id: group.id)
    group.rules << group_rule

    group.reload

    assert group.members.empty?, 'group should have no members'
  end

  test "Rule 'is_staff' works" do
    group_rule = GroupRule.new( column: 'is_staff', condition: 'is', value: true)

    setup_match = lambda {
      @person.is_staff = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_staff = false
      @person.save!
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'is_faculty' works" do
    group_rule = GroupRule.new(column: 'is_faculty', condition: 'is', value: true)

    setup_match = lambda {
      @person.is_faculty = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_faculty = false
      @person.save!
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'is_student' works" do
    group_rule = GroupRule.new(column: 'is_student', condition: 'is', value: true)

    setup_match = lambda {
      @person.is_student = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_student = false
      @person.save!
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'is_employee' works" do
    group_rule = GroupRule.new(column: 'is_employee', condition: 'is', value: true)

    setup_match = lambda {
      @person.is_employee = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_employee = false
      @person.save!
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'is_hs_employee' works" do
    group_rule = GroupRule.new(column: 'is_hs_employee', condition: 'is', value: true)

    setup_match = lambda {
      @person.is_hs_employee = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_hs_employee = false
      @person.save!
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'is_external' works" do
    group_rule = GroupRule.new(column: 'is_external', condition: 'is', value: true)

    setup_match = lambda {
      @person.is_external = true
      @person.save!
    }

    remove_match = lambda {
      @person.is_external = false
      @person.save!
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'title is' works" do
    group_rule = GroupRule.new(column: 'title', condition: 'is', value: titles(:programmer).code)

    setup_match = lambda {
      # Give a person an association involving a title with a 99-unit
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
      @person.reload
      assert @person.pps_associations.length == 1
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'sis_level_code' works" do
    group_rule = GroupRule.new(column: 'sis_level_code', condition: 'is', value: 'GR')

    setup_match = lambda {
      # Give a person a SIS association with level code 'GR'
      SisAssociationsService.add_sis_association_to_person(@person, Major.first, 1, 'GR')
    }

    remove_match = lambda {
      SisAssociationsService.remove_sis_association_from_person(@person, @person.sis_associations[0])
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'major' works" do
    group_rule = GroupRule.new(column: 'major', condition: 'is', value: 'History')

    setup_match = lambda {
      # Give a person a SIS association with level code 'GR'
      SisAssociationsService.add_sis_association_to_person(@person, Major.find_by(name: 'History'), 1, 'GR')
    }

    remove_match = lambda {
      SisAssociationsService.remove_sis_association_from_person(@person, @person.sis_associations[0])
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'pps_unit' works" do
    group_rule = GroupRule.new(column: 'pps_unit', condition: 'is', value: '99')

    setup_match = lambda {
      # Give a person an association involving a title with a 99-unit
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'pps_position_type' works" do
    group_rule = GroupRule.new(column: 'pps_position_type', condition: 'is', value: 2)

    setup_match = lambda {
      # Give a person an association involving a title with a 99-unit
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'business_office_unit' works" do
    group_rule = GroupRule.new(column: 'business_office_unit', condition: 'is', value: 'LETTERS AND SCIENCE: SOCIAL SCIENCES')

    evil_person = entities(:evil_casuser)

    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
      @person.reload

      evil_title = titles(:evil_programmer)
      evil_department = departments(:evil_dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(evil_person)
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(evil_person, evil_title, evil_department, department, department, 1, 2)
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

    test_group_rule(group_rule, setup_match, remove_match, 2)
  end

  test "Rule 'admin_business_office_unit' works" do
    group_rule = GroupRule.new(column: 'admin_business_office_unit', condition: 'is', value: 'ASSOCIATED STUDENT UNION')

    evil_person = entities(:evil_casuser)

    setup_match = lambda {
      # Put two people in the same department with different admin department BOUs
      title = titles(:programmer)
      department = departments(:dssit)
      admin_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
      @person.reload

      evil_title = titles(:evil_programmer)

      PpsAssociationsService.remove_all_pps_associations_from_person(evil_person)
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(evil_person, evil_title, department, admin_department, department, 1, 2)
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

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'appt_business_office_unit' works" do
    group_rule = GroupRule.new(column: 'appt_business_office_unit', condition: 'is', value: 'ASSOCIATED STUDENT UNION')

    evil_person = entities(:evil_casuser)

    setup_match = lambda {
      # Put two people in the same department with different admin department BOUs
      title = titles(:programmer)
      department = departments(:dssit)
      appt_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, appt_department, 1, 2)
      @person.reload

      evil_title = titles(:evil_programmer)

      PpsAssociationsService.remove_all_pps_associations_from_person(evil_person)
      evil_person.reload
      assert evil_person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(evil_person, evil_title, department, department, department, 1, 2)
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

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'department' works" do
    group_rule = GroupRule.new(column: 'department', condition: 'is', value: '040014')

    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, department, 1, 2)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'admin department' works" do
    group_rule = GroupRule.new(column: 'admin_department', condition: 'is', value: '410041')

    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)
      asucd_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, asucd_department, department, 1, 2)
      @person.reload
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule(group_rule, setup_match, remove_match)
  end

  test "Rule 'appt department' works" do
    group_rule = GroupRule.new(column: 'appt_department', condition: 'is', value: '410041')

    setup_match = lambda {
      # Put two people in two different depamrtnets under the same BOU
      title = titles(:programmer)
      department = departments(:dssit)
      asucd_department = departments(:asucd)

      PpsAssociationsService.remove_all_pps_associations_from_person(@person)
      @person.reload
      assert @person.pps_associations.count.zero?
      PpsAssociationsService.add_pps_association_to_person(@person, title, department, department, asucd_department, 1, 2)
      @person.reload
      assert @person.pps_associations.count == 1
    }

    remove_match = lambda {
      assert @person.pps_associations.length == 1
      PpsAssociationsService.remove_pps_association_from_person(@person, @person.pps_associations[0])
      @person.reload
      assert @person.pps_associations.count.zero?
    }

    test_group_rule(group_rule, setup_match, remove_match)
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
  def test_group_rule(group_rule, setup_match, remove_match, expected_member_count = 1)
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
      group.rules << group_rule

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
