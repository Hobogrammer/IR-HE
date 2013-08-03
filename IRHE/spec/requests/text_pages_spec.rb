require 'spec_helper'

describe "TextPages" do
 
  subject { page }

  describe "new text page" do

    describe "when not logged in" do
      before { visit new_text_path }

      it { should have_content('You need to be logged in to view this page') }
    end

    describe "when logged in" do
      before do
           let (:user) { FactoryGirl.create(:user) }
           sign_in user
           visit new_text_path
      end

      it { should have_content('Text Title:') }
      it { should have_content('Text Content') }
      it { should have_content('Tags') }
    end
  end
end
