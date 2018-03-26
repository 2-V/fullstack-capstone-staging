require 'rails_helper'

describe Foo, type: :model do
	include_context "db_cleanup", :transaction
	before(:all) do
		@foo=FactoryGirl.create(:foo, :name=>"test")
	end
	let(:foo) { Foo.find(@foo.id) }

	context "created Foo" do
		it { expect(foo).to be_persisted }
		it { expect(foo.name).to eq("test") }
		it { expect(Foo.find(foo.id)).to_not be_nil }
	end
end