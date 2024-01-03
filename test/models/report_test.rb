# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  setup do
    @report = create :report
    @author = @report.user
    @other = create :user

    @report_mentioned = create(
      :report,
      user: create(:user),
      content: 'test test 1'
    )
    @report_mentioning = create(
      :report,
      user: create(:user),
      content: "#{report_url(@report_mentioned, host: 'localhost:3000')} is mentioning."
    )
  end

  test 'report作成ユーザーがログインユーザーと同じ場合そのreportのeditableがtrueになる' do
    assert_equal true, @report.editable?(@author)
  end

  test 'report作成ユーザーがログインユーザーではない場合そのreportのeditableがfalseになる' do
    assert_equal false, @report.editable?(@other)
  end

  test 'created_onを呼び出して指定の日時が返る' do
    @report.created_at = '2023-11-11 23:30:19'
    assert_equal Date.new(2023, 11, 11), @report.created_on
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
