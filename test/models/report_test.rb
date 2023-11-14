# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase

  setup do
    @test_report = Report.new
    @test_report.user = users(:one)
  end

  test 'ログインユーザーがreport作成ユーザーと同じ場合editableがtrueになる' do
    assert_equal true, @test_report.editable?(users(:one))
  end

  test 'ログインユーザがreport作成ユーザーと違う場合はeditableがfalseになる' do
    assert_equal false, @test_report.editable?(users(:two))
  end

  test 'created_onを呼び出して指定の日時が返る' do
    @test_report.created_at = '2023-11-11'
    assert_equal Date.new(2023, 11, 11), @test_report.created_on
  end
end
