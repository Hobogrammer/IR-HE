class WordsController < ApplicationController
  before_action :signed_in_user, only: [:create, :new]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @word = Word.new
  end

  def create
    @word = current_user.words.build(word_params)

    respond_to do |format|

      if @word.save
        flash[:success] = "Word Saved"
        format.js { render :action => 'create_success' }
      else
        flash[:error] = "Word failed to save"
        format.js { render :action => 'create_fail' }
      end
    end
  end

  def show
    @word = Word.find_by_user_id(params[:id])
  end

  def index
  end

  def destroy
  end


  private
     def word_params
      params.require(:word).permit(:term,:definition,:sentence,:tags,:share, :text_id)
    end

    def correct_user
     @word = current_user.words.find_by_id(params[:id])
      redirect_to(panel_path) if @word.nil?
    end

end
