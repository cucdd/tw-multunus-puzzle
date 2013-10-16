require 'spec_helper'

describe "persons/show.html.erb", :type => :feature do
  before :each do
    visit '/persons/github'
  end

  it "should have div with class 'tw-content'" do
    expect(page).to have_css 'div.tw-content'
  end
end
