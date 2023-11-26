# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = create(:report)
    @author = @report.user
    @not_author = create(:user)
  end

  test 'ログインユーザーがreport作成ユーザーと同じ場合editableがtrueになる' do
    assert_equal true, @report.editable?(@author)
  end

  test 'ログインユーザがreport作成ユーザーと違う場合はeditableがfalseになる' do
    assert_equal false, @report.editable?(@not_author)
  end

  test 'created_onを呼び出して指定の日時が返る' do
    @report.created_at = '2023-11-11 23:30:19'
    assert_equal Date.new(2023, 11, 11), @report.created_on
  end
end
