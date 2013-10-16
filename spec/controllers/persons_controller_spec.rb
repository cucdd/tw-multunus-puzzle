require 'spec_helper'

describe PersonsController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      person = Person[1].name
      get :show, id: person
      expect(response.status).to eq(200)
    end
  end

end
