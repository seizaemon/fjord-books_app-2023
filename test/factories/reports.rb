# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    sequence(:title) { |n| "My title#{n}" }
    sequence(:content) { |n| "My text#{n}" }
    user
  end
end
