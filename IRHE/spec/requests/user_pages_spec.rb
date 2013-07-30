require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "visiting user panel" do
    let (:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit panel_path
    end

    it { should have_selector 'h1', text: user.name }

    describe "user main navigation" do

      it { should have_link('Texts', users_texts_path(:user) ) }
      it { should have_link('Saved Words', users_words_path(:user)) }
      it { should have_link('Add a Text', new_users_text_path) }
    end
  end
end
