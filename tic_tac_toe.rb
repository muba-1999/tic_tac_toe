class TicTacToe
	attr_reader :current_winner
	def initialize
		@board = Array.new(9, " ")
		@current_winner = nil
	end
	def print_board()
		puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
		puts "--+---+--"
		puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
		puts "--+---+--"
		puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
	end

	def available_move
		moves = []

		for spot in (0...@board.length)
			if @board[spot] == " "
				moves.push(spot)
			end
		end
		return moves
	end

	def empty_spot
		return @board.include?(" ")
	end

	def make_move(spot, letter)
		if @board[spot] == " "
			@board[spot] = letter
			if winner(letter)
				@current_winner = letter
			end
			return true
		else
			return false
		end
	end

	def winner(letter)
		if @board[0] == letter && @board[1] == letter && @board[2] == letter
			return true
		elsif @board[3] == letter && @board[4] == letter && @board[5] == letter
			return true
		elsif @board[6] == letter && @board[7] == letter && @board[8] == letter
			return true
		end

		if @board[0] == letter && @board[3] == letter && @board[6] == letter
			return true
		elsif @board[1] == letter && @board[4] == letter && @board[7] == letter
			return true
		elsif @board[2] == letter && @board[5] == letter && @board[8] == letter
			return true
		end

		if @board[0] == letter && @board[4] == letter && @board[8] == letter
			return true
		elsif @board[2] == letter && @board[4] == letter && @board[6] == letter
			return true
		end
		return false
	end
end

def play(game, x_player, o_player, print_game=true)
	if print_game
		game.print_board
	end

	letter = 'X'

	while game.empty_spot
		if letter == 'O'
			spot = o_player.get_move(game)
		else
			spot = x_player.get_move(game)
		end
		if game.make_move(spot, letter)
			if print_game
				puts "#{letter} makes a move at #{spot}"
				game.print_board
				puts
			end

			if game.current_winner
				if print_game
					puts "#{letter} wins!"
				end
				return letter
			end 

			if letter == 'X'
				letter = 'O'
			else
				letter = 'X'
			end
		end
	end
	if print_game
		puts "its a Tie!"
	end
end


class Player
	def initialize(letter)
		@letter = letter
	end

	def get_move(game)
	end
end

class Computer_player < Player
	def initialize(letter)
		super(letter)
	end

	def get_move(game)
		spot = rand(0...game.available_move.length)
		return game.available_move[spot]
	end
end

class Human_player < Player
	def initialize(letter)
		super(letter)
	end
	
	def get_move(game)
		valid_spot = false
		value = nil

		while !valid_spot
			puts "#{@letter}'s turn. Enter move from (0-8)"
			spot = gets.chomp

			value = spot.to_i
			if game.available_move.include?(value)
				valid_spot = true
			else
				puts "This value is not valid"
			end
		end
		return value
	end
end


puts "======================================="
puts "Welcome To a Game Of Tic Tac Toe"
puts "======================================="
puts
puts "Press 1 to play against a human player or press 2 to play against a computer"

choice = gets.chomp.to_i 
if choice == 1
	o_player = Human_player.new('O')
else choice == 2
	o_player = Computer_player.new('O')
end
x_player = Human_player.new('X')
game = TicTacToe.new
play(game, x_player, o_player, print_game = true)