class Game
	# initializes board and performs welcome
	def initialize
		@board = Board.new
		@comp_gen = false
		welcome		
	end

	# welcomes player to game and demands that they press P to start
	def welcome
		puts "Welcome to MASTERMIND!"
		type = nil
		until type == 1 || type == 2
			puts "\nWould you like to guess the code (enter 1) or create your own (enter 2)?"
			type = gets.chomp.to_i
		end
		if type == 1
			@comp_gen = true
			play
		elsif type == 2
			@puter = Computer.new
			computer_play
		end

	end

	# main game loop for human guesses
	def play
		puts "The computer has generated a code. You must guess it."
		puts "Colors available: (B)lue, (G)reen, (O)range, (P)ink, (R)ed, and (Y)ellow."
		
		loop do 			
			guess						
			game_over? 
			print_board
		end		
	end

	# variant for computer guesses
	def computer_play
		puts "Enter your code for the computer to guess!"
		puts "Colors available: (B)lue, (G)reen, (O)range, (P)ink, (R)ed, and (Y)ellow."
		@board.new_solution(gets.chomp.upcase.split(""))

		loop do
			@board.new_guess(@puter.guess)			
			game_over? 
		end				
	end

	# main guess output/input, feeds to Board guess processing method
	def guess
		puts "\n\n\nPlease enter your guess in the form XXXX!"
		@board.new_guess(gets.chomp.upcase.split(""))
	end

	# prints the whole board, used after every guess - computer or human
	def print_board
		@board.code_pegs.each_with_index do |pegs, i|
			pegs.each { |p| print "#{p} " }
			print " - #{@board.key_pegs[i][0]} correct; #{@board.key_pegs[i][1]} close\n"
		end
	end

	# checks if the game has ended, quits appropriately
	def game_over?
		if @board.win?
			print_board
			puts "\nThe codebreaker wins it!"
			exit
		elsif @board.lose?
			print_board
			puts "The codemaster has won! \nAnswer:"
			print "#{@board.solution[0]} #{@board.solution[1]} "
			print "#{@board.solution[2]} #{@board.solution[3]}\n\n"
			exit
		else
			false
		end
	end




	class	Board
		attr_reader :code_pegs, :key_pegs, :possible_colors
		attr_accessor :solution

		# initializes an array for guesses, responses, each possible color, and the solution
		def initialize			
			@code_pegs = []
			@key_pegs = []
			@possible_colors = ["B", "G", "O", "P", "R", "Y"]
			@solution = generate_solution
		end

		# computer generates random code for cracking
		def generate_solution		
			out = []
			4.times { out << @possible_colors[rand(6)] }
			out
		end

		# populates the key_pegs array with this turn's key pegs - 
		def generate_key_pegs
			next_key_peg = []
			no_duplicate = []

			@code_pegs.last.each_with_index do |peg, i|
				if peg == @solution[i]
					next_key_peg << 1  # correct place
					no_duplicate << peg 
				end
			end

			@code_pegs.last.each_with_index do |peg, i|
				if @solution.include?(peg) && peg != @solution[i] && (@solution.count(peg) > no_duplicate.count(peg))
					next_key_peg << 2  # correct color
				end
			end

			@key_pegs << [next_key_peg.count(1), next_key_peg.count(2)]
		end

		# processes a new guess from the game object
		def new_guess(guess)
			until validate_entry?(guess)
				puts "Error! Please enter a 4 letter string!"
				guess = gets.chomp.upcase.split("")
			end
			@code_pegs << guess
			generate_key_pegs
		end

		# accepts user-inputted solution
		def new_solution(entry)
			until validate_entry?(entry)
				puts "Error! Please enter a 4 letter string!"
				entry = gets.chomp.upcase.split("")
			end
		end

		# validates the guess to ensure that it is 4 characters, all among possible characters
		def validate_entry?(guess)
			guess.length == 4 && guess.all? { |color| @possible_colors.include?(color) }
		end

		# checks for win
		def win?
			if @code_pegs.last == @solution
				true
			else
				false
			end
		end

		# checks for loss
		def lose?
			if @code_pegs.length == 12
				true
			else
				false
			end
		end

	end

	# automatically guesses
	class Computer
		def initialize
			
		end

		def guess
			guess = []
			4.times { guess << ["B", "G", "O", "P", "R", "Y"][rand(6)] }
			guess
		end

	end

end

Game.new.play