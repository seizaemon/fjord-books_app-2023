# frozen_string_literal: true

FactoryBot.define do
  factory :report_comment, class: 'Comment' do
    sequence(:content) { |n| "test report comment #{n}" }
    user
    commentable_type { 'Report' }
    commentable factory: :report
  end

  factory :book_comment, class: 'Comment' do
    sequence(:content) { |n| "test book comment #{n}" }
    user
    commentable_type { 'Book' }
    commentable factory: :book
  end
end
