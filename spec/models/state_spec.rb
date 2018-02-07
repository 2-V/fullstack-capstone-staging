require 'rails_helper'

require 'mongo'
Mongo::Logger.logger.level = ::Logger::INFO

describe State, :type=>:model, :orm =>:mongoid do 
	include_context "db_cleanup"

	context State do
		it { is_expected.to have_field(:name).of_type(String).with_default_value_of(nil) }
	end

	context "created State" do
		subject { State.create(:name => "test") }
		include_context "db_scope"

		it { is_expected.to be_persisted }
		it { expect(subject.name).to eq("test") }
		it { expect(State.find(subject.id)).to_not be_nil }
	
	end
end