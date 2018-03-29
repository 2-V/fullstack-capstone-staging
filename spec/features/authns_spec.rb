require 'rails_helper'

RSpec.feature "Authns", type: :feature, :js=>true do 
	include_context "db_cleanup_each"
	let(:user_props) { FactoryGirl.attributes_for(:user) } 

	feature "sign-up" do
		context "valid registration" do
			scenario "creates account and navigates away from signup page" do
				start_time=Time.now
				signup user_props

				#check we re-directed to home page
				expect(page).to have_no_css("#signup-form")
				#check the DB for the existance of the User account
				user=User.where(:email=>user_props[:email]).first
				#make sure we were the ones that created it
				expect(user.created_at).to be > start_time
			end
		end
	end
end