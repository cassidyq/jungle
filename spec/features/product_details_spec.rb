require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  
    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end
  
    scenario "They see all products and can click on an individual product to view" do
      # ACT
      visit root_path

      first('.actions').click_link('Details')

      # DEBUG
      save_screenshot
  
      # VERIFY
      expect(page).to have_css 'main section.products-show'
    end
  end