require "test_helper"

describe Text do
  let(:text) { Text.new }

  it "must be valid" do
    text.must_be :valid?
  end
end
