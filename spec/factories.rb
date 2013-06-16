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

  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    project
  end

  factory :structure do
    sequence(:name) { |n| "Structure #{n}" }
    group
  end

  factory :dataval do
    sequence(:value) { |n| "Data value #{n}" }
    structure
  end
end
