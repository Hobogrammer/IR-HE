class TextsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  REDACTOR_TAGS = %w(span div label a br p b i del strike u img video audio
                  blockquote mark cite small ul ol li hr dl dt dd sup sub big pre figure 
                  figcaption strong em table tr td th tbody thead tfoot h1 h2 h3 h4 h5 h6)

  REDACTOR_ATTRIBUTES = %w(href)
  def index
    @texts = Text.all.to_a
  end

  def new
    @text = Text.new
  end

  def create
    params[:content] = sanitize_redactor(params[:content])
    @text = current_user.texts.build(text_params)
    if @text.save
      flash[:success] = "Text Saved"
      redirect_to panel_path #Change to texts_path when that is finished
    else 
      flash[:error] = "Text failed to save, please try again"
      render 'new'
    end
  end

  def shared
  end

  def show
    @text = Text.find_by_id(params[:id])
    @word = current_user.words.build
    @text_id = params[:id]
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

    def sanitize_redactor(orig)
      stripped = view_context.strip_tags(orig)
      if stripped.present?
        view_context.sanitize(orig, tags: REDACTOR_TAGS, attributes: REDACTOR_ATTRIBUTES)
      else
        nil
      end
    end
end