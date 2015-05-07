require 'spec_helper'

describe 'Tic Tac Toe' do 

	before :all do
		@game = Game.new
	end

	before :each do
		@board = Game::Board.new
	end

	describe 'Game' do

		describe '#initialize' do
			it 'initializes a board' do
				expect(@game.ttt.grid.length).to be(9)
			end

			it 'initializes player x' do 
				expect(@game.x.xoro).to eq("X")
			end

			it 'initializes player o' do
				expect(@game.o.xoro).to eq("O")
			end

			it 'initializes player counter' do 
				expect(@game.player_number).to be(0)
			end
		end

		describe '#turn' do
			it 'accepts input, assigns a box' do 
				@game.instance_eval('@player_number = 2')
				allow(@game).to receive(:gets) do
					@counter ||= 1
					response = @counter > 4 ? '1' : '0'
					@counter += 1
					response
				end
				@game.turn
				expect(@game.board.grid[0]).to eq('x')
			end
		end

	end

	describe 'Board' do
		
		describe '#assign_box' do

			it 'assigns a box x' do
				@board.assign_box(1,'x')
				expect(@board.grid[0]).to eq('x')
			end

			it 'assigns a box o' do
				@board.assign_box(9,'o')
				expect(@board.grid[8]).to eq('o')
			end

			it 'loops a nope' do
				allow(@board).to receive(:gets) do
					@counter ||= 1
					response = counter > 3 ? 'o' : 'f'
					@counter += 1
					response
				end
				expect(@board.assign_box(4,'4')).to eq('pass')
			end

		end


	end




	describe 'end of game' do

		describe '#winner?' do

			it 'wins across' do
				@board.assign_box(1,'x')
				@board.assign_box(2,'x')
				@board.assign_box(3,'x')
				win = @board.winner?
				expect(win).to be(true)
			end

			it 'wins down' do
				@board.assign_box(1,'x')
				@board.assign_box(4,'x')
				@board.assign_box(7,'x')
				win = @board.winner?
				expect(win).to be(true)
			end

			it 'wins diagonal' do
				@board.assign_box(1,'x')
				@board.assign_box(5,'x')
				@board.assign_box(9,'x')
				win = @board.winner?
				expect(win).to be(true)
			end

			it 'returns false for no winner' do
				@board.assign_box(1,'o')
				@board.assign_box(2,'x')
				@board.assign_box(3,'o')
				@board.assign_box(4,'x')
				@board.assign_box(5,'x')
				@board.assign_box(6,'o')
				@board.assign_box(7,'o')
				@board.assign_box(8,'o')
				@board.assign_box(9,'x')
				win = @board.winner?
				expect(win).to be(false)

			end

			it 'returns cat' do
				@board.assign_box(1,'o')
				@board.assign_box(2,'x')
				@board.assign_box(3,'o')
				@board.assign_box(4,'x')
				@board.assign_box(5,'x')
				@board.assign_box(6,'o')
				@board.assign_box(7,'o')
				@board.assign_box(8,'o')
				@board.assign_box(9,'x')
				cat = @board.cat_game?
				expect(cat).to be(true)
			end

			it 'returns false for cat' do
				@board.assign_box(1,'x')
				@board.assign_box(2,'o')	
				cat = @board.cat_game?
				expect(cat).to be(false)
			end


		end


	end






# start by testing player wins (across, diagonal, down)
# make sure critical methods work and handle edge cases
# use mocks/doubles to isolate methods and make sure they're sending they right outputs

	
end