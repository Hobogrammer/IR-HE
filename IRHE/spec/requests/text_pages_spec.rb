require 'spec_helper'

describe "TextPages" do
 
  subject { page }

  describe "new text page" do

    describe "when not logged in" do
      before { visit new_text_path }

      it { should have_content('You must be logged in to do view this page. Please sign in.') }
    end

    describe "when logged in" do
      let (:user) { FactoryGirl.create(:user) }
      before do          
           sign_in user
           visit new_text_path
      end

      it { should have_content('Title') }
      it { should have_content('Content') }
      it { should have_content('Language') }
      it { should have_content('Tags') }
      it { should have_content('Share') }
    end
  end

  describe "displaying a text" do

  
  end
end
