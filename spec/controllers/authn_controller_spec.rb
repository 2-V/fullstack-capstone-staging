require 'rails_helper'

RSpec.describe AuthnController, type: :controller do

  describe "GET #whoami" do
    it "returns http success" do
      get :whoami
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #checkme" do
    it "returns http success" do
      get :checkme
      expect(response).to have_http_status(:success)
    end
  end

end
