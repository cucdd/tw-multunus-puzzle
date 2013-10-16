require 'spec_helper'

describe "persons/index.html.erb", :type => :feature do
  before :each do
    visit root_path
  end

  it "has the right title" do
    expect(page).to have_title 'tw-multunus-puzzle'
  end

  it "cantains ul with class 'gallery'" do
    expect(page).to have_css 'ul.gallery'
  end

  it "should have link to 'github'" do
    expect(page).to have_link("", {:href => 'persons/github'})
  end
end
