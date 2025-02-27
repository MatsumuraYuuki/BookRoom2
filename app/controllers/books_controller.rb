class BooksController < ApplicationController
  def search
    @query = params[:query]
    @books = @query.present? ? GoogleBooksApi.search(@query) : []
  end
end
