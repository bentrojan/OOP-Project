# controls the gaming board
class Board

	# initializes the board with a 9-place array, each with value " " to be adjusted later
	def initialize
	  @grid = []
	  9.times { @grid << " " }
	end

	# draws a sample board, to show 1-9 locations
	def sample_board
	  puts "\n\n1|2|3"
	  puts "-----"
	  puts "4|5|6"
	  puts "-----"
	  puts "7|8|9"
	end

	# draws the board
	def view_board
	  puts "\n\n#{@grid[0]}|#{@grid[1]}|#{@grid[2]}"
	  puts "-----"
	  puts "#{@grid[3]}|#{@grid[4]}|#{@grid[5]}"
	  puts "-----"
	  puts "#{@grid[6]}|#{@grid[7]}|#{@grid[8]}"

	  winner?
	end

	# assigns X or O to a box - checks box is vacant and number is 1-9
	def assign_box(box, xoro)
	  until (box > 0 && box < 10) && (@grid[box-1] == " ")
		puts "nope, try again"
		box = gets.chomp.to_i
	  end
	  @grid[box-1] = xoro
	end

	# checks for winning move 123, 147, 159, 789, 369, 357, 258, 456
	def winner?
	  if( 
		([@grid[0], @grid[1], @grid[2]].uniq.length == 1 && @grid[0] != " ") ||
		([@grid[0], @grid[3], @grid[6]].uniq.length == 1 && @grid[0] != " ") ||
		([@grid[0], @grid[4], @grid[8]].uniq.length == 1 && @grid[0] != " ") ||
		([@grid[6], @grid[7], @grid[8]].uniq.length == 1 && @grid[6] != " ") ||
		([@grid[2], @grid[5], @grid[8]].uniq.length == 1 && @grid[2] != " ") ||
		([@grid[2], @grid[4], @grid[6]].uniq.length == 1 && @grid[2] != " ") ||
		([@grid[1], @grid[4], @grid[7]].uniq.length == 1 && @grid[1] != " ") ||
		([@grid[3], @grid[4], @grid[5]].uniq.length == 1 && @grid[3] != " ")
		)
		true
	  else
		false
	  end
	end

	# checks for a draw
	def cat_game?
	  !(@grid.include?(" "))
	end

end





class Player
	attr_reader :xoro

	#identifies the player as the X or the O
	def initialize(xoro)
	  @xoro = xoro
	end

end


#
# start of the program
#
#============================================
# 

ttt = Board.new
ttt.sample_board
x = Player.new("X")
o = Player.new("O")
player_number = 0 # counter even numbers will be player X, odd player O


loop do
  player_number += 1
  puts "\n\n"
  ttt.view_board

  if player_number % 2 == 0
		puts "Player X choose your box! 1-9"
		ttt.assign_box(gets.chomp.to_i, x.xoro)
  else
		puts "Player O choose your box! 1-9"
		ttt.assign_box(gets.chomp.to_i, o.xoro)
  end 

	if ttt.winner?
		ttt.view_board
		puts player_number % 2 == 0 ? "\nX is the winner!" : "\nO is the winner!"
		exit
	end		

  if ttt.cat_game?
		puts "\n\n=^.^="
		ttt.view_board
		puts "=^.^="
		puts "cat's game! game over!"
		exit
  end

end



# to do list:
# => shouldn't be able to overwrite boxes
# => should end with the cat's game
# => maybe print the grid with numbers to start