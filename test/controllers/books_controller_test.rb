# frozen_string_literal: true

require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @book = books(:one)
  end

  test 'should get index' do
    sign_in users(:one)
    get books_url
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:one)
    get new_book_url
    assert_response :success
  end

  test 'should create book' do
    sign_in users(:one)
    assert_difference('Book.count') do
      post books_url, params: { book: { memo: @book.memo, title: @book.title } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test 'should show book' do
    sign_in users(:one)
    get book_url(@book)
    assert_response :success
  end

  test 'should get edit' do
    sign_in users(:one)
    get edit_book_url(@book)
    assert_response :success
  end

  test 'should update book' do
    sign_in users(:one)
    patch book_url(@book), params: { book: { memo: @book.memo, title: @book.title } }
    assert_redirected_to book_url(@book)
  end

  test 'should destroy book' do
    sign_in users(:one)
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
