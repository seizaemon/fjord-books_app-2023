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
    @report_mentioned.save
    @report_mentioning.save
  end

  test 'メンションされていることが記録される' do
    assert_equal @report_mentioned.mentioned_reports.to_a, [@report_mentioning]
  end

  test 'メンションしていることが記録される' do
    assert_equal @report_mentioning.mentioning_reports.to_a, [@report_mentioned]
  end
end