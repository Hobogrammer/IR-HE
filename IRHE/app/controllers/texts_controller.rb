class TextsController < ApplicationController

  def index
  end

  def new
    @text = current_user.texts.build(text_params)
  end

  def create
    @text = current_user.texts.build(text_params)
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
      params.require(:text).permit(:title,:content,:language,:tags,:share, :id)
    end
end