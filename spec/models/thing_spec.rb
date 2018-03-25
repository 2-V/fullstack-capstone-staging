require 'rails_helper'

RSpec.describe Thing, type: :model do
  include_context "db_cleanup"

  context "build valid thing" do
  	it "default thing created with random name" do
  		thing=FactoryGirl.build(:thing)
  		expect(thing.name).to_not be_nil
  		expect(thing.save).to be true
  	end
  	it "thing with User and non-nil name" do
  		user=FactoryGirl.create(:user)
  		thing=FactoryGirl.build(:thing)
	  	expect(thing.name).to_not be_nil
	  	expect(thing.save).to be true
  	end
  	it "thing with no name" do
  		thing=FactoryGirl.build(:thing, name:nil)
  		
  		expect(thing.save).to be false
  	end
  end
end
