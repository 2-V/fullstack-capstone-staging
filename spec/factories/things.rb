FactoryGirl.define do
  factory :thing_faker, class: 'Thing' do
  	name { Faker::Address.community }
  	description { Faker::Lorem.sentence(1).chomp(".")}
  	notes { Faker::Lorem.sentence(2).chomp(".")}
  end

  factory :thing, :parent=>:thing_faker do
  end
end
