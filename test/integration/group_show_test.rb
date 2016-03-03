require 'test_helper'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist

class GroupShowTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

#   test "ensure non-admins can edit their groups using the UI" do
#     ## Ensure we can get to the page and open the modal
#     visit('/applications')
#     current_path == applications_path()
    
#     # Click the first sidebar link FIXME: Should select a single one
#     find('#sidebar .entity-details-link').trigger('click')
    
#     # Modal should appear
#     find('#entityShowModal')
    
#     # Modal title should be Group's name
#     assert find('.modal-header h3').text == "Group A", "Modal title was expected to be name of group, 'Group A'"
    
#     # ## Now let's try adding an owner
#     #
#     # # Click the 'Relations' navigation option
#     # find('.modal-body a[href=\#relations]').trigger('click')
    
    
    
#     # TODO: Finish me.
#   end
  
  test "ensure non-admins can create a group" do
    # Open applications#index page
    visit '/applications'
    current_path == applications_path()
    
    keypress_script = "$('#search_sidebar').val('Some New Group').keyup();"
    page.evaluate_script(keypress_script)
    
    find('#search_sidebar').click()
    
    #save_and_open_screenshot

    el_found = false
    page.all(:css, 'ul.dropdown-menu li').each do |el|
        if el.text == 'Create Group Some New Group'
            el.click()
            el_found = true
            break
        end
    end
    
    assert el_found == true, "could not find 'Create Group' link in dropdown"
    
    wait_for_ajax
    
    # Ensure the new group named 'Some New Group' shows up in the sidebar
    found_new_group = false
    page.all(:css, '#sidebar li.group span#name').each do |el|
        if el.text == 'Some New Group'
            found_new_group = true
            break
        end
    end
    assert found_new_group, "expected name of group in right sidebar"
  end

  # ensure they can add a favorite and server returns success, re-load model and ensure favorite is there, same for unfavorite
  # ensure they can create a group, delete a group, edit a group
  # ensure they can import a person, edit a person, deactivate a person
end
