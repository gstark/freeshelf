class BooksController < ApplicationController
  before_action :authorize!, except: [:index, :show]

  # Like in express...  
  # app.get('/books', (req, res) => {
  #  const all_books = [....]
  #  res.render('index.mustace', { books: all_books})
  # })
  #
  # GET /books
  def index
    page_number = params[:page]

    @books = Book.page(page_number)
  end

  # GET /books/1
  def show
    @book = Book.find(params[:id])

    @comment = @book.comments.new
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])

    # If we aren't the book's user, redirect to the books_path
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    @book = Book.find(params[:id])

    # If we aren't the book's user, redirect to the books_path
    unless @book.user == current_user
      redirect_to books_path
      return
    end

    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book = Book.find(params[:id])

    # If we aren't the book's user, redirect to the books_path
    unless @book.user == current_user
      redirect_to books_path
      return
    end

    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def book_params
    params.require(:book).permit(:title, :author, :description, :url)
  end
end
