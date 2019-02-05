require 'rails_helper'

describe "on the welcome page" do
  it "should have welcome content" do
    visit root_path
    expect(page).to have_content("Hello, world!")
  end

end
