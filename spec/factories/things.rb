FactoryGirl.define do
  factory :thing do
    name { Faker::Name.name }
    sequence(:description) {|n| n%5==0 ? nil : Faker::Lorem.paragraphs.join}
    sequence(:notes) {|n| n%5<2 ? nil : Faker::Lorem.paragraphs.join }

    trait :with_image do
    	transient do
    		image_count 1
    	end
    	after(:build) do |thing, props|
    		thing.thing_images << build_list(:thing_image, props.image_count, :thing=>thing)
    	end
    end

    trait :with_notes do
    	notes { Faker::Lorem.sentence(1).chomp(".") }
    end
  end
end
