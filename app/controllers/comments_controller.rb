class CommentsController < ApplicationController
  before_action :authorize!

  # GET /comments/new
  def new
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new
  end

  # POST /comments
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @book, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:message)
  end
end
