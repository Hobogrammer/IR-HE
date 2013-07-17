FactoryGirl.define do 
  factory :user do
    name "JowJebus"
    provider "twitter"
    uid "123456"

    factory :admin do
      admin true
    end
  end
end