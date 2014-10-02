require 'sinatra/base'
require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'cell'

class BattleShips < Sinatra::Base

GAME = Game.new

set :views, Proc.new { File.join(root, "..", "views") }
enable :sessions


  get '/' do
  	puts session.inspect
  	puts "******"
  	puts GAME.inspect
    erb :index
  end

  post '/registered' do
  	session[:me] = params[:player_name]
  	@name = session[:me]
  	GAME.add_player(@name)
  	puts GAME.inspect
  	erb :registered
  end

  get '/registered' do 
      @name = session[:me]
      erb :registered
    end


  get '/board' do 
    BOARD = Board.new(Cell)
    puts BOARD.inspect
    @board = BOARD.grid
    erb :board
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
