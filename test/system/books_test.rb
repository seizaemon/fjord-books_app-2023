# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @book = create :book
    @new_book = build :book
    @user = create :user
    sign_in @user
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: I18n.t('views.common.title_index', name: Book.model_name.human)
  end

  test 'should create book' do
    visit books_url
    click_on I18n.t('views.common.new', name: Book.model_name.human)

    fill_in_context
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('controllers.common.notice_create', name: Book.model_name.human)
    click_on I18n.t('views.common.back', name: Book.model_name.human)
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on I18n.t('views.common.edit', name: Book.model_name.human), match: :first

    fill_in_context
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('controllers.common.notice_update', name: Book.model_name.human)
    click_on I18n.t('views.common.back', name: Book.model_name.human)
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on I18n.t('views.common.destroy', name: Book.model_name.human), match: :first

    assert_text I18n.t('controllers.common.notice_destroy', name: Book.model_name.human)
  end

  test 'コメントの追加' do
    visit book_url(@book)

    fill_in 'comment_content', with: 'コメント'
    click_on I18n.t('shared.comments.create')

    assert_text I18n.t('controllers.common.notice_create', name: Comment.model_name.human)
    click_on I18n.t('views.common.back', name: Book.model_name.human)
  end

  test 'コメントの削除' do
    create :book_comment, user: @user, commentable: @book
    visit book_url(@book)

    accept_confirm do
      click_on I18n.t('shared.comments.delete'), match: :first
    end

    assert_text I18n.t('controllers.common.notice_destroy', name: Comment.model_name.human)
    click_on I18n.t('views.common.back', name: Book.model_name.human)
  end

  test '自分の書いたコメント以外は削除できない' do
    create :book_comment, commentable: @book
    visit book_url(@book)

    assert_no_selector I18n.t('shared.comments.delete')
    click_on I18n.t('views.common.back', name: Book.model_name.human)
  end

  private

  def fill_in_context
    fill_in I18n.t('activerecord.attributes.book.memo'), with: @new_book.memo
    fill_in I18n.t('activerecord.attributes.book.title'), with: @new_book.title
  end
end
