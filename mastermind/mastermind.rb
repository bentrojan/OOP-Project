class Game

	def initialize
		@board = Board.new
		welcome
	end

	def welcome
		puts "Welcome to MASTERMIND!"
		loop do
			puts "Enter P to play!"
			break if gets.chomp.upcase == "P" 
		end
		play
	end

	def play
		puts "The computer has generated a code. You must guess it."
		puts "Colors available: (B)lue, (G)reen, (O)range, (P)ink, (R)ed, and (Y)ellow."
		
		loop do 			
			guess			
			@board.code_pegs.each_with_index do |pegs, i|
				pegs.each { |p| print "#{p} " }
				print " - #{@board.key_pegs[i][0]} correct; #{@board.key_pegs[i][1]} close\n"
			end
			game_over? 
		end		
	end

	def guess
		puts "\n\n\nPlease enter your guess in the form XXXX!"
		@board.new_guess(gets.chomp.upcase)
	end

	def game_over?
		if @board.win?
			puts "CONGRATULATIONS YOU'VE WON!"
			exit
		elsif @board.lose?
			puts "You have lost! No sprinkles for you. \nAnswer:"
			print "#{@board.solution[0]} #{@board.solution[1]} "
			print "#{@board.solution[2]} #{@board.solution[3]}\n\n"
			exit
		else
			false
		end
	end




	class	Board
		attr_reader :code_pegs, :key_pegs, :solution

		def initialize			
			@code_pegs = []
			@key_pegs = []
			@possible_colors = ["B", "G", "O", "P", "R", "Y"]
			@solution = generate_solution
		end

		def generate_solution		
			out = []
			4.times { out << @possible_colors[rand(6)] }
			out
		end

		# populates the key_pegs array with this turn's key pegs - 
		def generate_key_pegs
			next_key_peg = []
			stop_add = []
			@code_pegs.last.each_with_index do |peg, i|
				if peg == @solution[i]
					next_key_peg << 1  # correct place
					stop_add << peg 
				end
			end
			@code_pegs.last.each_with_index do |peg, i|
				if @solution.include?(peg) && peg != @solution[i] && (@solution.count(peg) > stop_add.count(peg))
					next_key_peg << 2  # correct color
				end
			end

			@key_pegs << [next_key_peg.count(1), next_key_peg.count(2)]
		end

		def new_guess(guess)
			until validate_guess?(guess)
				puts "Error! Please enter a 4 letter string!"
				guess = gets.chomp.upcase
			end
			@code_pegs << guess.split("")
			generate_key_pegs
		end

		def validate_guess?(guess)
			guess.length == 4 && guess.split("").all? { |color| @possible_colors.include?(color) }
		end

		def win?
			if @code_pegs.last == @solution
				true
			else
				false
			end
		end

		def lose?
			if @code_pegs.length == 12
				true
			else
				false
			end
		end

	end

end

Game.new.play