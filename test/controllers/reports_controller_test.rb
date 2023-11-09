# frozen_string_literal: true

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @report = reports(:one)
  end

  test 'should get index' do
    sign_in users(:one)
    get reports_url
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:one)
    get new_report_url
    assert_response :success
  end

  test 'should create report' do
    sign_in users(:one)
    assert_difference('Report.count') do
      post reports_url, params: { report: { content: @report.content, title: @report.title, user_id: @report.user_id } }
    end

    assert_redirected_to report_url(Report.last)
  end

  test 'should show report' do
    sign_in users(:one)
    get report_url(@report)
    assert_response :success
  end

  test 'should get edit' do
    sign_in users(:one)
    get edit_report_url(@report)
    assert_response :success
  end

  test 'should update report' do
    sign_in users(:one)
    patch report_url(@report), params: { report: { content: @report.content, title: @report.title, user_id: @report.user_id } }
    assert_redirected_to report_url(@report)
  end

  test 'should destroy report' do
    sign_in users(:one)
    assert_difference('Report.count', -1) do
      delete report_url(@report)
    end

    assert_redirected_to reports_url
  end
end
