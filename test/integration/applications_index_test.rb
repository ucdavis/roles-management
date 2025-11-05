# require 'test_helper'
# require 'capybara/rails'
# require 'capybara/poltergeist'

# Capybara.default_driver = :poltergeist

# class ApplicationsIndexTest < ActionDispatch::IntegrationTest
#   include Capybara::DSL

#   setup do
#     fake_cas_login
#   end

#   test "shows application cards" do
#     visit('/applications')
#     current_path == applications_path()
    
#     # Check for the cards-area
#     assert page.has_selector?('#cards-area'), 'page lacks div#cards-area'
    
#     # Check for the applciation cards 'casuser' has access to
#     assert page.all(:css, '.card').count == entities(:casuser).manageable_applications.length, 'page should have as many div.card elements as current_user has manageable_applications'
    
#     # page.all('.card').each do |card|
#     #   puts card.tag_name
#     #   puts card[:id]
#     # end
    
#     # print page.html
#   end

#   test "inactive entities appear in search" do
#     visit('/applications')
#     current_path == applications_path()
    
#     # Check for the cards-area
#     assert page.has_selector?('#cards-area'), 'page lacks div#cards-area'
    
#     # Check for the applciation cards 'casuser' has access to
#     assert page.all(:css, '.card').count == entities(:casuser).manageable_applications.length, 'page should have as many div.card elements as current_user has manageable_applications'
    
#     # # page.all('.card').each do |card|
#     # #   puts card.tag_name
#     # #   puts card[:id]
#     # # end
#     #
#     # #print page.html
#   end
# end
