require 'rails_helper'
require 'support/foo_ui_helper.rb'

RSpec.feature "ManageFoos", type: :feature, :js=>true do
  include_context "db_cleanup_each"
  include FooUiHelper
  FOO_FORM_XPATH=FooUiHelper::FOO_FORM_XPATH
  FOO_LIST_XPATH=FooUiHelper::FOO_LIST_XPATH

  #FOO_FORM_CSS="body > div > div > div > div > form"
  #FOO_FORM_XPATH="//h3[text()='Foos']/../form"
  #FOO_LIST_XPATH="//h3[text()='Foos']/../ul"

  let(:foo_state) { FactoryGirl.attributes_for(:foo) }

  feature "view existing Foos" do
  	let(:foos) { (1..5).map{ FactoryGirl.create(:foo) }.sort_by {|v| v["name"]}}

  	scenario "when no instances exist" do
  		visit root_path
  		within(:xpath,FOO_LIST_XPATH) do
  			expect(page).to have_no_css("li") #this or next row work and do same test
  			expect(page).to have_css("li", count:0)
  		end
  	end
  	scenario "when instances exist" do
  		visit root_path if foos
  		within(:xpath,FOO_LIST_XPATH) do
  			expect(page).to have_css("li:nth-child(#{foos.count})") #this or next row work and do same test
  			expect(page).to have_css("li", count:foos.count)
  		end
  	end
  end

  feature "add new Foo" do
  	
  	background(:each) do
  		visit root_path
  		expect(page).to have_css("h3", text:"Foos")
      within(:xpath,FOO_LIST_XPATH) do
    		expect(page).to have_css("li", count:0)
      end
  	end

  	scenario "has input form" do
  		expect(page).to have_css("label", :text=>"Name:")
  		expect(page).to have_css("input[name='name'][ng-model*='foo.name']")
  		expect(page).to have_css("button[ng-click*='create()']", :text=>"Create Foo")
  		expect(page).to have_button("Create Foo")
  	end
  	scenario "complete form with helper" do
  		create_foo foo_state

  		within(:xpath,FOO_LIST_XPATH) do
  			expect(page).to have_css("li", count:1)
  		end
  	end
  end

  feature "with existing Foo" do
  	background(:each) do
  		create_foo foo_state
  	end


  	scenario "can be updated" do
  		existing_name=foo_state[:name]
  		new_name=FactoryGirl.attributes_for(:foo)[:name]

  		within(:xpath,FOO_LIST_XPATH) do
  			expect(page).to have_css("li", :count=>1)
  			expect(page).to have_css("li", :text=>existing_name)
  			expect(page).to have_no_css("li", :text=>new_name)
  		end

  		update_foo(existing_name, new_name)

  		within(:xpath,FOO_LIST_XPATH) do
  			expect(page).to have_css("li", :count=>1)
  			expect(page).to have_no_css("li", :text=>existing_name)
  			expect(page).to have_css("li", :text=>new_name)
  		end
  	end
  	scenario "can be deleted" do
		within(:xpath,FOO_LIST_XPATH) do
			expect(page).to have_css("a",text:foo_state[:name])
		end

		delete_foo foo_state[:name]

		within(:xpath,FOO_LIST_XPATH) do
			expect(page).to have_no_css("a",text:foo_state[:name])
		end
  	end
  end
end
