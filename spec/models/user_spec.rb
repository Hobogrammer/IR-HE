require 'spec_helper'

describe User do
  
  before { @user = User.new(name: "Tom Jones", provider: "twitter", uid: 123456 , tz: "GMT") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:tz) }
  it { should respond_to(:admin) }
  it { should respond_to(:texts) }
  it { should respond_to(:words) }
  it { should respond_to(:avatar) }

  it { should_not be_admin }

  describe "when admin is set to true" do
    before { @user.toggle!(:admin) }

    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = "" }

    it { should_not be_valid }
  end

  describe "when provider is not present" do
    before { @user.provider = "" }

    it { should_not be_valid }
  end 

  describe "when uid is not present" do
    before { @user.uid = "" }

    it { should_not be_valid }
  end

end
