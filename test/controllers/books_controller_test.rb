# frozen_string_literal: true

require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @book = create :book
    @new_book = build :book
    sign_in create :user
  end

  test 'should get index' do
    get books_url
    assert_response :success
  end

  test 'should get new' do
    get new_book_url
    assert_response :success
  end

  test 'should create book' do
    assert_difference('Book.count', 1) do
      post books_url, params: { book: { memo: @new_book.memo, title: @new_book.title } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test 'should show book' do
    get book_url(@book)
    assert_response :success
  end

  test 'should get edit' do
    get edit_book_url(@book)
    assert_response :success
  end

  test 'should update book' do
    patch book_url(@book), params: { book: { memo: @new_book.memo, title: @new_book.title } }
    assert_redirected_to book_url(@book)
  end

  test 'should destroy book' do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  test 'bookのcommentが削除できる' do
    commented_book = create :book_comment
    sign_in commented_book.user
    delete comment_url(commented_book)
    assert_redirected_to book_url commented_book.commentable
  end
end
