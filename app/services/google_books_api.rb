require 'faraday'
require 'json'

class GoogleBooksApi
  BASE_URL = 'https://www.googleapis.com/books/v1/volumes'.freeze

  def self.search(query, max_results = 24)
    return [] if query.nil?

    response = fetch_from_api(query, max_results)
    process_response(response)
  rescue Faraday::Error => e # エラーが発生した場合のみ rescue ブロック内の処理が実行
    log_error(e)
    []
  end

  class << self
    private

    # Google Books APIにクエリを送信しレスポンスを取得する
    def fetch_from_api(query, max_results)
      conn = Faraday.new(url: BASE_URL)
      conn.get do |req|
        req.params['q'] = query
        req.params['maxResults'] = max_results
      end
    end

    # APIレスポンスを解析して書籍情報の配列を返す
    def process_response(response)
      return [] unless response.success?

      result = JSON.parse(response.body)
      return [] unless result['items']

      result['items'].map { |item| extract_book_info(item['volumeInfo']) }
    end

    # volumeInfo から必要な書籍情報を抽出しハッシュとして返す
    def extract_book_info(volume_info)
      {
        title: volume_info['title'],
        author: volume_info['authors']&.join(', '),
        isbn: extract_isbn(volume_info),
        published_date: volume_info['publishedDate'],
        thumbnail_url: volume_info['imageLinks']&.dig('thumbnail'),
        publisher: volume_info['publisher']
      }
    end

    # 書籍のISBN情報を抽出し、ISBN-13を優先して返す
    def extract_isbn(volume_info)
      isbn13 = volume_info['industryIdentifiers']&.find { |id| id['type'] == 'ISBN_13' }&.dig('identifier')
      isbn10 = volume_info['industryIdentifiers']&.find { |id| id['type'] == 'ISBN_10' }&.dig('identifier')

      isbn13 || isbn10 # ISBN-13を優先し、なければISBN-10を使用
    end

    # エラー情報をログに記録する
    def log_error(error)
      Rails.logger.error "Google Books API error: #{error.message}"
    end
  end
end
