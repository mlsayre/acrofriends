require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { name: @game.name, r1cat: @game.r1cat, r1letters: @game.r1letters, r2cat: @game.r2cat, r2letters: @game.r2letters, r3cat: @game.r3cat, r3letters: @game.r3letters, r4cat: @game.r4cat, r4letters: @game.r4letters }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    patch :update, id: @game, game: { name: @game.name, r1cat: @game.r1cat, r1letters: @game.r1letters, r2cat: @game.r2cat, r2letters: @game.r2letters, r3cat: @game.r3cat, r3letters: @game.r3letters, r4cat: @game.r4cat, r4letters: @game.r4letters }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
