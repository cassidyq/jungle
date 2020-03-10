require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
 
  
    # SETUP
    before :each do
      @user = User.create!(name: "Cat Woman",
                           email: "cat@woman.com",
                           password: "password",
                           password_confirmation: "password")
    end
  
    scenario "They login successfully and are taken to the home page once signed in" do
      # ACT
      visit '/login'

      fill_in 'email', with: 'cat@woman.com'
      fill_in 'password', with: 'password'
      click_on 'Submit'

      # DEBUG
      save_screenshot
  
      # VERIFY
      expect(page).to have_text 'Products'
    end
  end