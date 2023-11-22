# frozen_string_literal: true

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @report = create(:report)
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
    new_report = build(:report)
    assert_difference('Report.count') do
      post reports_url, params: { report: { content: new_report.content, title: new_report.title, user_id: @report.user_id } }
    end

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
    update_report = build(:report)
    patch report_url(@report), params: { report: { content: update_report.content, title: update_report.title, user_id: @report.user_id } }
    assert_redirected_to report_url(@report)
  end

  test 'should destroy report' do
    assert_difference('Report.count', -1) do
      delete report_url(@report)
    end

    assert_redirected_to reports_url
  end
end
