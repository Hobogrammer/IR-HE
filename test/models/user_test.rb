require "test_helper"

describe User do
  let(:user) { User.new }

  it { assert_respond_to(user, :name) }
  it { assert_respond_to(user, :provider) }
  it { assert_respond_to(user, :uid) }
  it { assert_respond_to(user, :avatar_url) }
end
