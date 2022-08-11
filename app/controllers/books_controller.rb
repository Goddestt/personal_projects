class BooksController < ApplicationController
  before_action :find_user
  skip_before_action :authenticate, only: :index
  before_action :find_book, only: %i[show edit update destroy borrow update_return preview]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
    @link_for_search = "books"
  end

  def new
    @book = Book.new
    @book.build_page
    @shelves = Shelf.all
  end

  def create
    @book = Book.new(book_params)
    @book.belonger = Shelf.find_by(id: params[:book][:shelf_id])
    if @book.save
      redirect_to books_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @book.build_page if @book.page.nil?
    @shelves = Shelf.all
  end

  def update
    @book.belonger = Shelf.find(params[:shelf_id])
    @book.assign_attributes(book_params)
    if @book.save
      redirect_to edit_book_path(@book)
    else
      flash.now[:errors] = "This is an error"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to books_path if @book.destroy
  end

  def get_self_borrow_list
    @q = current_user.books.ransack(params[:q])
    @books = @q.result(distinct: true)
    @link_for_search = "get_self_borrow_list"
    render :index
  end

  def borrow
    if @book.reload.belonger_type == "Shelf"
      redirect_to get_self_borrow_list_books_path if @book.update(belonger: current_user, returned_date: nil)
    end
  end

  def returning_book
    @shelves = Shelf.all
  end

  def preview
    @pdf = @book.pdf_preview
    send_data(@pdf, disposition: "inline", type: "application/pdf", filename: "preview")
  end

  def update_return
    shelf = Shelf.find_by(id: params[:shelf_id])
    if @book.reload.belonger.is_a? User
      redirect_to root_path if @book.update(belonger: shelf, returned_date: Time.now)
    end
  end

  private

  def find_user
    @user = current_user if session[:user_type] == "User"
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:id, :name, :author, :barcode, :cover_image, :description, page_attributes: [:content])
  end
end
