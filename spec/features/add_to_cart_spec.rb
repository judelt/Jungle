require 'rails_helper'

RSpec.feature "Add To Cart", type: :feature, js: true do 

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

  scenario "users can navigate from the home page to the product detail page by clicking on a product" do 
    # ACT
    visit root_path
    # VERIFY
    expect(page).to have_css 'article.product', count: 10

    # ACT
    first('article.product').click_on('Add')
    # VERIFY
    expect(page).to have_text 'My Cart (1)'
    # DEBUG
    # save_screenshot
  
  end

end
