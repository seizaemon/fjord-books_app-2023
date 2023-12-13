# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book title#{n}" }
    sequence(:memo) { |n| "Book comment#{n}" }
  end
end
