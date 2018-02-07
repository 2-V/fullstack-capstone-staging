FactoryGirl.define do
  factory :state_fixed, class: 'State' do
    name "test"

  end

  factory :state_sequence, class: 'State' do
  	sequence(:name) {|n| "test#{n}" }
  end

  factory :state_names, class: 'State' do
  	sequence(:name) {|n| ["Townville", "State", "Village"][n%3] }
  end

  factory :state_transient, class: 'State' do
  	transient do
  		male true
  	end

  	after(:build) do |object, props|
  		object.name = props.male ? "Mr Test" : "Ms Test"
  	end
  end

  factory :state_ctor, class: 'State' do
  	transient do
  		hash {}
  	end
  	initialize_with { State.new(hash) }
  end

  factory :state_faker, class: 'State' do
  	name { Faker::Name.name }
  end

  factory :state, :parent=>:state_faker do
  end
end
