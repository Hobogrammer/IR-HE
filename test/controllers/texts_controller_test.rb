require "test_helper"

describe TextsController do

  let(:text) { texts :one }

  it "gets index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:texts)
  end

  it "gets new" do
    get :new
    assert_response :success
  end

  it "creates text" do
    assert_difference('Text.count') do
      post :create, text: {  }
    end

    assert_redirected_to text_path(assigns(:text))
  end

  it "shows text" do
    get :show, id: text
    assert_response :success
  end

  it "gets edit" do
    get :edit, id: text
    assert_response :success
  end

  it "updates text" do
    put :update, id: text, text: {  }
    assert_redirected_to text_path(assigns(:text))
  end

  it "destroys text" do
    assert_difference('Text.count', -1) do
      delete :destroy, id: text
    end

    assert_redirected_to texts_path
  end

end
