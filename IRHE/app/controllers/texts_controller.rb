class TextsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :destroy, :edit]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @texts = Text.all
  end

  def new
    @text = Text.new
  end

  def create
    @text = Text.new(text_params)
    if @text.save
      flash[:success] = "Text Saved"
      redirect_to panel_path #Change to texts_path when that is finished
    else 
      flash[:error] = "Text did not save correctly, please try again"
    end
  end

  def shared
  end

  def show
  end

  def edit
  end

  private
    def text_params
      params.require(:text).permit(:title,:content,:language,:tags,:share, :user_id)
    end
end
