# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book title#{n}" }
    sequence(:memo) { |n| "Book comment#{n}" }
    sequence(:author) { |n| "Book author#{n}" }
  end
end
