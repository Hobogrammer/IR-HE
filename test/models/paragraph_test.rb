require "test_helper"

describe Paragraph do
  let(:paragraph) { Paragraph.new }

  it "must be valid" do
    paragraph.must_be :valid?
  end
end
