class BooksController < ApplicationController
  before_action :find_user
  before_action :find_book, only: %i[show edit update destroy]

  def index
    @books = @user.books
  end

  def new
    @book = Book.new
  end

  def create
    @book = @user.books.new(book_params)
    if @book.save
      redirect_to user_books_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  rescue StandardError => e
    @errors = e
    @users = User.all
    flash.now[:alert] = "This user was not found"
    render "index"
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to edit_user_book_path(@book)
    else
      flash.now[:errors] = "This is an error"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to user_books_path if @book.destroy
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:id, :name, :price, :author, :user_id, :barcode, :cover_image)
  end
end
