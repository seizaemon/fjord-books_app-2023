# frozen_string_literal: true

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @report = create :report
    @new_report = build :report
    @mentioning_report = create(
      :report,
      user: create(:user),
      content: "#{report_url(@report, host: 'localhost:3000')} is mentioning."
    )
    @user = @report.user
    sign_in @user
  end

  test 'should get index' do
    get reports_url
    assert_response :success
  end

  test 'should get new' do
    get new_report_url
    assert_response :success
  end

  test 'should create report' do
    assert_difference('Report.count', 1) do
      post reports_url, params: { report: {
        content: @new_report.content,
        title: @new_report.title,
        user_id: @report.user_id
      } }
    end

    assert_equal Report.last.content, @new_report.content
    assert_equal Report.last.title, @new_report.title
    assert_redirected_to report_url(Report.last)
  end

  test 'should show report' do
    get report_url(@report)
    assert_response :success
  end

  test 'should get edit' do
    get edit_report_url(@report)
    assert_response :success
  end

  test 'should update report' do
    patch report_url(@report), params: { report: { content: @new_report.content, title: @new_report.title }}
    @report.reload

    assert_equal @report.content, @new_report.content
    assert_equal @report.title, @new_report.title
    assert_redirected_to report_url(@report)
  end

  test 'should destroy report' do
    assert_difference('Report.count', -1) do
      delete report_url(@report)
    end

    assert_equal Report.where(id: @report.id), []
    assert_redirected_to reports_url
  end

  test 'reportにcommentを追加できる' do
    new_comment = build :report_comment
    sign_in new_comment.user

    assert_difference('Comment.count', 1) do
      post report_comments_url(@report, new_comment), params: { comment: {
        content: new_comment.content
      }}
    end
    assert_equal Comment.last.content, new_comment.content
    assert_equal Comment.last.user, new_comment.user
  end

  test 'reportのcommentが削除できる' do
    posted_comment = create :report_comment
    sign_in posted_comment.user
    delete comment_url(posted_comment)

    assert_equal Comment.where(id: posted_comment.id), []
    assert_redirected_to report_url posted_comment.commentable
  end

  test 'reportのメンション内容を変更するとメンションされている先も変更になる' do
    new_mentioned_report = create :report
    sign_in @mentioning_report.user
    patch report_url(@mentioning_report), params: {
      report: {
        content: "#{report_url(new_mentioned_report, host: 'localhost:3000')} is mentioning.",
      }
    }
    @report.reload
    @mentioning_report.reload

    assert_equal @report.mentioned_reports.to_a, []
    assert_equal new_mentioned_report.mentioned_reports.to_a, [@mentioning_report]
    assert_redirected_to report_url @mentioning_report
  end

  test 'reportのメンション内容を変更するとメンションしている先も変更になる' do
    new_mentioned_report = create :report
    sign_in @mentioning_report.user
    patch report_url(@mentioning_report), params: {
      report: {
        content: "#{report_url(new_mentioned_report, host: 'localhost:3000')} is mentioning.",
      }
    }
    @mentioning_report.reload

    assert_equal @mentioning_report.mentioning_reports.to_a, [new_mentioned_report]
    assert_redirected_to report_url @mentioning_report
  end

  test 'メンション込みのコメントを削除するとメンションしている参照も削除される' do
    sign_in @mentioning_report.user
    patch report_url(@mentioning_report), params: {
      report: {
        content: 'no mentioning.'
      }
    }
    @mentioning_report.reload

    assert_equal @mentioning_report.mentioning_reports.to_a, []
    assert_redirected_to report_url @mentioning_report
  end

  test 'メンション込みのコメントを削除するとメンションされている参照も削除される' do
    sign_in @mentioning_report.user
    patch report_url(@mentioning_report), params: {
      report: {
        content: 'no mentioning.'
      }
    }

    assert_equal @report.mentioned_reports.to_a, []
    assert_redirected_to report_url @mentioning_report
  end
end