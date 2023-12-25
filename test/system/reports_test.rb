# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @report = create :report
    @new_report = build :report
    sign_in @report.user
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: I18n.t('views.common.title_index', name: Report.model_name.human)
  end

  test 'should create report' do
    visit reports_url
    click_on I18n.t('views.common.new', name: Report.model_name.human)
    fill_in I18n.t('activerecord.attributes.report.content'), with: @new_report.content
    fill_in I18n.t('activerecord.attributes.report.title'), with: @new_report.title

    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('controllers.common.notice_create', name: Report.model_name.human)
    assert_text "#{Report.human_attribute_name(:title)}: #{@new_report.title}"
    assert_text "#{Report.human_attribute_name(:content)}: #{@new_report.content}"
    assert_text "#{Report.human_attribute_name(:user)}: #{@report.user.name_or_email}"
    assert_link @report.user.name_or_email, href: user_path(@report.user)
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on I18n.t('views.common.edit', name: Report.model_name.human), match: :first
    fill_in I18n.t('activerecord.attributes.report.content'), with: @new_report.content
    fill_in I18n.t('activerecord.attributes.report.title'), with: @new_report.title

    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('controllers.common.notice_update', name: Report.model_name.human)
    assert_text "#{Report.human_attribute_name(:title)}: #{@new_report.title}"
    assert_text "#{Report.human_attribute_name(:content)}: #{@new_report.content}"
    assert_text "#{Report.human_attribute_name(:user)}: #{@report.user.name_or_email}"
    assert_link @report.user.name_or_email, href: user_path(@report.user)
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on I18n.t('shared.comments.delete'), match: :first

    assert_text I18n.t('controllers.common.notice_destroy', name: Report.model_name.human)
    assert_not Report.where(id: @report.id).exists?
  end

  test 'コメントの追加' do
    visit report_url(@report)
    fill_in 'comment_content', with: 'コメントテストreport'
    click_on I18n.t('shared.comments.create')

    assert_text I18n.t('controllers.common.notice_create', name: Comment.model_name.human)
    assert_selector 'div.comments-container>ul>li:last-child', text: 'コメントテストreport'
  end

  test 'コメントの削除' do
    created_comment = create :report_comment, user: @report.user, commentable: @report
    visit report_url(@report)

    accept_confirm do
      click_on I18n.t('shared.comments.delete'), match: :first
    end

    assert_text I18n.t('controllers.common.notice_destroy', name: Comment.model_name.human)
    assert_not Comment.where(id: created_comment.id).exists?
  end

  test '自分の書いたコメント以外は削除できない' do
    create :report_comment, commentable: @report
    visit report_url(@report)

    assert_no_selector I18n.t('shared.comments.delete')
  end

  test 'メールアドレスとパスワードでログインし日報を書く' do
    # このテストは未ログイン状態からスタートする
    sign_out @report.user

    visit new_user_session_url

    fill_in 'user_email', with: @report.user.email
    fill_in 'user_password', with: @report.user.password
    click_on 'commit'

    # メニューの日報を押す
    click_on Report.model_name.human
    click_on I18n.t('views.common.new', name: Report.model_name.human)
    fill_in I18n.t('activerecord.attributes.report.content'), with: @new_report.content
    fill_in I18n.t('activerecord.attributes.report.title'), with: @new_report.title
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('controllers.common.notice_create', name: Report.model_name.human)
    assert_text "#{Report.human_attribute_name(:title)}: #{@new_report.title}"
    assert_text "#{Report.human_attribute_name(:content)}: #{@new_report.content}"
    assert_text "#{Report.human_attribute_name(:user)}: #{@report.user.name_or_email}"
    assert_link @report.user.name_or_email, href: user_path(@report.user)
  end
end
