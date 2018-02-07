require 'rails_helper'
require 'support/city_ui_helper.rb'

RSpec.feature "ManageCities", type: :feature, :js=>true do
  include_context "db_cleanup_each"
  include CityUiHelper
  CITY_FORM_XPATH=CityUiHelper::CITY_FORM_XPATH
  CITY_LIST_XPATH=CityUiHelper::CITY_LIST_XPATH

  #CITY_FORM_CSS="body > div > div > div > div > form"
  #CITY_FORM_XPATH="//h3[text()='Cities']/../form"
  #CITY_LIST_XPATH="//h3[text()='Cities']/../ul"

  let(:city_state) { FactoryGirl.attributes_for(:city) }

  feature "view existing Cities" do
  	let(:cities) { (1..5).map{ FactoryGirl.create(:city) }.sort_by {|v| v["name"]}}

  	scenario "when no instances exist" do
  		visit root_path
  		within(:xpath,CITY_LIST_XPATH) do
  			expect(page).to have_no_css("li") #this or next row work and do same test
  			expect(page).to have_css("li", count:0)
  		end
  	end
  	scenario "when instances exist" do
  		visit root_path if cities
  		within(:xpath,CITY_LIST_XPATH) do
  			expect(page).to have_css("li:nth-child(#{cities.count})") #this or next row work and do same test
  			expect(page).to have_css("li", count:cities.count)
  		end
  	end
  end

  feature "add new City" do
  	
  	background(:each) do
  		visit root_path
  		expect(page).to have_css("h3", text:"Cities")
  		expect(page).to have_css("li", count:0)
  	end

  	scenario "has input form" do
  		expect(page).to have_css("label", :text=>"Name:")
  		expect(page).to have_css("input[name='name'][ng-model*='city.name']")
  		expect(page).to have_css("button[ng-click*='create()']", :text=>"Create City")
  		expect(page).to have_button("Create City")
  	end
  	scenario "complete form with helper" do
  		create_city city_state

  		within(:xpath,CITY_LIST_XPATH) do
  			expect(page).to have_css("li", count:1)
  		end
  	end
  end

  feature "with existing City" do
  	background(:each) do
  		create_city city_state
  	end


  	scenario "can be updated" do
  		existing_name=city_state[:name]
  		new_name=FactoryGirl.attributes_for(:city)[:name]

  		within(:xpath,CITY_LIST_XPATH) do
  			expect(page).to have_css("li", :count=>1)
  			expect(page).to have_css("li", :text=>existing_name)
  			expect(page).to have_no_css("li", :text=>new_name)
  		end

  		update_city(existing_name, new_name)

  		within(:xpath,CITY_LIST_XPATH) do
  			expect(page).to have_css("li", :count=>1)
  			expect(page).to have_no_css("li", :text=>existing_name)
  			expect(page).to have_css("li", :text=>new_name)
  		end
  	end
  	scenario "can be deleted" do
		within(:xpath,CITY_LIST_XPATH) do
			expect(page).to have_css("a",text:city_state[:name])
		end

		delete_city city_state[:name]

		within(:xpath,CITY_LIST_XPATH) do
			expect(page).to have_no_css("a",text:city_state[:name])
		end
  	end
  end
end
