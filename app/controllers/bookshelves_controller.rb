class BookshelvesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookshelf, only: [:update, :destroy]

  def index
    # 「最初に全データを取得してから、必要に応じてフィルタリングする」という2段階の処理をしている
    @bookshelves = current_user.bookshelves.includes(:book).page(params[:page]).per(12)

    # ステータスによるフィルタリング
    @bookshelves = @bookshelves.where(status: params[:status]) if params[:status].present?
  end

  def create
    #  トランザクションを開始（本の作成と本棚への追加を一連の処理として保証）
    ActiveRecord::Base.transaction do
      book_data = book_params.to_h.symbolize_keys

      # 本のインスタンスを作成または取得
      @book = find_or_create_book(book_data)

      # 既存の本棚に同じ本があるか確認
      existing_bookshelf = current_user.bookshelves.find_by(book: @book)

      if existing_bookshelf
        # 既存の本棚アイテムを更新
        existing_bookshelf.update!(status: params[:status] || 'want_to_read')
        redirect_to bookshelves_path, notice: '本棚の状態を更新しました'
        return
      end

      # 新規に本棚に追加
      @bookshelf = current_user.bookshelves.build(
        book: @book,
        status: params[:status] || 'want_to_read'
      )

      if @bookshelf.save
        redirect_to bookshelves_path, notice: '本棚に追加しました'
      else
        redirect_to search_books_path, alert: '本棚への追加に失敗しました'
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to search_books_path, alert: "登録に失敗しました: #{e.message}"
  rescue JSON::ParserError => e
    redirect_to search_books_path, alert: "本のデータの解析に失敗しました"
  end

  def update
    if @bookshelf.update(bookshelf_params)
      redirect_to bookshelves_path, notice: '本棚を更新しました'
    else
      redirect_to bookshelves_path, alert: '本棚の更新に失敗しました'
    end
  end

  def destroy
    @bookshelf.destroy
    redirect_to bookshelves_path, notice: '本棚から削除しました'
  end

  private

  def set_bookshelf
    @bookshelf = current_user.bookshelves.find(params[:id])
  end

  def bookshelf_params
    params.require(:bookshelf).permit(:status)
  end

  # BookshelvesControllerのcreateアクション中に呼ばれる
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :published_date, :thumbnail_url, :publisher)
  end

  # book_dataからそれがbookDBに登録されているか検索、なければ作成する
  def find_or_create_book(book_data)
    # どの要素で検索するか(ISBN or タイトルと著者)
    # ここでオブジェクト作成(DBにsaveはされない)
    book = if book_data[:isbn].present?
             Book.find_or_initialize_by(isbn: book_data[:isbn])
           else
             Book.find_or_initialize_by(
               title: book_data[:title],
               author: book_data[:author]
             )
           end

    # 本が新規作成の場合は属性を設定して保存
    unless book.persisted? # DBに保存済みかどうかをチェック(保存されてないなら今作成されたはず)
      book.assign_attributes( # 作成したオブジェクトに対し要素を追加
        title: book_data[:title],
        author: book_data[:author],
        isbn: book_data[:isbn],
        published_date: book_data[:published_date],
        thumbnail_url: book_data[:thumbnail_url],
        publisher: book_data[:publisher]
      )
      book.save!
    end

    book
  end
end
