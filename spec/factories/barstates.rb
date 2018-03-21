FactoryGirl.define do
  factory :bar_fixed, class: 'Bar' do
    name "test"

  end

  factory :bar_sequence, class: 'Bar' do
  	sequence(:name) {|n| "test#{n}" }
  end

  factory :bar_names, class: 'Bar' do
  	sequence(:name) {|n| ["Townville", "Bar", "Village"][n%3] }
  end

  factory :bar_transient, class: 'Bar' do
  	transient do
  		male true
  	end

  	after(:build) do |object, props|
  		object.name = props.male ? "Mr Test" : "Ms Test"
  	end
  end

  factory :bar_ctor, class: 'Bar' do
  	transient do
  		hash {}
  	end
  	initialize_with { Bar.new(hash) }
  end

  factory :bar_faker, class: 'Bar' do
  	name { Faker::Name.name }
  end

  factory :bar, :parent=>:bar_faker do
  end
end
