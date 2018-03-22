require 'rails_helper'

RSpec.describe "Foo API", type: :request do
  include_context "db_cleanup_each"

  context "caller requests list of Foos" do

  	it_should_behave_like "resource index", :foo

  	let(:response_check) do
  		expect(payload.count).to eq(resources.count)
  		expect(payload.map{|f|f["name"]}).to eq(resources.map{|f|f[:name]})
  	end
  end

  context "a specific Foo exists" do
  	it_should_behave_like "show resource", :foo
  end

  context "create a new Foo" do
  	it_should_behave_like "create resource", :foo
  end

  context "existing Foo" do
  	it_should_behave_like "modifiable resource", :foo
  end
end
