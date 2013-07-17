require 'spec_helper'

describe "StaticPages" do
  
  subject { page }

  describe "Home page" do
    before { visit root_path }

    describe "when not signed in" do
        it { should have_link( "Sign in via Twitter", href: signin_path) }
    end

    describe "for signed in users" do
      let (:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end

      it { should have_selector('p', text: user.name) }
      it { should_not have_link("Sign in via Twitter", href: signin_path) }
      it { should have_link("Click here to sign out" , href: signout_path ) }
    end
  end
end
