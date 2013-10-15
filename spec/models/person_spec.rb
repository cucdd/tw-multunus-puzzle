require 'spec_helper'

describe Person do
  it "rake task should seed correctly" do
    expect(Person.all.size).to eq 9
  end
end
