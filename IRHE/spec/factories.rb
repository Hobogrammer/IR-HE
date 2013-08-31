FactoryGirl.define do 
  factory :user do
    name "JowJebus"
    provider "twitter"
    uid "123456"

    factory :admin do
      admin true
    end
  end

    factory :text do
      sequence(:title) { |n| "Text_#{n}" }
      sequence(:content) { |n| "Lorem ipsum Ex magna enim aliquip qui voluptate laborum est cupidatat deserunt elit consequat. #{n}" }
      language "latin"
      share "false"
      user
  end
end