require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "visiting user home page" do
    let (:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit user_path(:user)
    end

    it { should have_selctor 'h1', text: user.name }
  end
end
