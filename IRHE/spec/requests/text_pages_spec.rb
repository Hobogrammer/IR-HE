require 'spec_helper'

describe "TextPages" do
 
  subject { page }

  describe "new text page" do
    before { visit new_text_path }

    describe "when not logged in" do
      it { should have_content('error') }
    end

    describe "when logged in" do
      it { should have_content('Text Title:') }
      it { should have_content('Text Content') }
      it { should have_content('Tags') }
    end
  end
end
