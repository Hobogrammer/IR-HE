require 'spec_helper'

describe Text do
  
  before { @text = Text.new(user_id: 1, title: "Lorem",
                                                content: "Lorem ipsum Nulla irure ad exercitation sint officia fugiat nisi aliquip esse veniam fugiat cillum voluptate do voluptate irure amet dolor sed.",
                                                language: "Latin", tags: "filler", share: false) }
  subject { @text }

  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:tags) }
  it { should respond_to(:language) }
  it { should respond_to(:share) }

  describe "when user_id is not present" do
    before { @text.user_id = "" }

    it { should_not be_valid }
  end

  describe "when title is not present" do
    before {@text.title = "" }

    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { @text.content = "" }

    it { should_not be_valid }
  end

  describe "when language is not present" do
    before { @text.language = "" }

    it { should_not be_valid }
  end
end
