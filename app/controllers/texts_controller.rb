class TextsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :destroy, :edit]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @texts = Text.all.to_a
  end

  def new
    @text = Text.new
  end

  def create
    @text = current_user.texts.build(text_params)
    if @text.save
      flash[:success] = "Text Saved"
      redirect_to panel_path #Change to texts_path when that is finished
    else 
      flash[:error] = "Flash failed to save, please try again"
      render 'new'
    end
  end

  def shared
  end

  def show
    @text = Text.find_by_id(params[:id])
    @word = current_user.words.build
  end

  def edit
    @text = Text.find_by_id(params[:id]) 
  end

  def lookup
    word = params[:query]

    definition = Text.yahoo_mech(word)
    if definition.first.blank?
      response = { 'code' => 0 } 
    else
      response = { 'code' => 2, 'query' => word, 'def' => definition.first.to_s }
    end

    respond_to do |format|
      format.json { render :json => response }
    end
  end

  def wordsearch
    selection = params[:query]

    word_check = Text.mecab_check(selection).first.to_s

    if word_check == false || word_check.blank?
      word_check = false
      response = { 'word' => word_check }
    else
      response = { 'word' => word_check, 'offset_add' => word_check.length }
    end

     respond_to do |format|
      format.json { render :json =>  response }
    end
  end

  def demo
    @text = Text.find_by_id(5)
  end

  private
    def text_params
      params.require(:text).permit(:title,:content,:language,:tags,:share, :user_id)
    end

   

    def correct_user
     @text = current_user.texts.find_by_id(params[:id])
      redirect_to(panel_path) if @text.nil?
    end
end
