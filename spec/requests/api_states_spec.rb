require 'rails_helper'

RSpec.describe "States API", type: :request do
  include_context "db_cleanup_each"

  context "caller requests list of States" do
  	it_should_behave_like "resource index", :state do
  		let(:response_check) do
  			expect(payload.count).to eq(resources.count);
  			expect(payload.map{|f|f["name"]}).to eq(resources.map{|f|f[:name]})
  		end
  	end
  end

  context "a specific State exists" do
  	it_should_behave_like "show resource", :state
  end

  context "create a new State" do
  	it_should_behave_like "create resource", :state
  end

  context "existing State" do
  	it_should_behave_like "modifiable resource", :state
  end
end
