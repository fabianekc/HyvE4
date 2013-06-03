FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"

    factory :admin do
      admin true
    end
  end

  factory :posting do
    content "Lorem ipsum"
    user
  end

  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    user
    description "Lorem ipsum"
  end
end
