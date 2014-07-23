require 'test_helper'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist

class GroupShowTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  test "ensure non-admins can edit their groups using the UI" do
    ## Ensure we can get to the page and open the modal
    visit('/applications')
    current_path == applications_path()

    # # Click the first sidebar link FIXME: Should select a single one
    # find('#sidebar .entity-details-link').trigger('click')
    #
    # # Modal should appear
    # find('#entityShowModal')
    #
    # # Modal title should be Group's name
    # assert find('.modal-header h3').text == "Group A", "Modal title was expected to be name of group, 'Group A'"
    #
    # ## Now let's try adding an owner
    #
    # # Click the 'Relations' navigation option
    # find('.modal-body a[href=\#relations]').trigger('click')



    # TODO: Finish me.
  end

  # ensure they can add a favorite and server returns success, re-load model and ensure favorite is there, same for unfavorite
  # ensure they can create a group, delete a group, edit a group
  # ensure they can import a person, edit a person, deactivate a person
end
