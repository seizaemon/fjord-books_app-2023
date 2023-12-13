# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  setup do
    @report_mentioned = create(
      :report,
      user: create(:user),
      content: 'test test'
    )
    @report_mentioning = create(
      :report,
      user: create(:user),
      content: "#{report_url(@report_mentioned, host: 'localhost:3000')} is mentioning."
    )
  end

  test 'メンションされていることが記録される' do
    assert_equal @report_mentioned.mentioned_reports.to_a, [@report_mentioning]
  end

  test 'メンションしていることが記録される' do
    assert_equal @report_mentioning.mentioning_reports.to_a, [@report_mentioned]
  end

  test '自分が書いたメンションは記録されない' do
    report_self_mentioning = create(
      :report,
      user: @report_mentioned.user,
      content: "#{report_url(@report_mentioned, host: 'localhost:3000')} is mentioning."
    )

    assert_equal report_self_mentioning.mentioned_reports.to_a, []
  end
end
