require 'pry'

class Game
    attr_accessor :player_1, :player_2, :board
    #attr_reader :player_1, :player_2, :board
    

        WIN_COMBINATIONS = [
                [0,1,2],
                [3,4,5],
                [6,7,8],
                [0,3,6],
                [1,4,7],
                [2,5,8],
                [0,4,8],
                [2,4,6]
]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
        @board.display
    end

    def current_player
        @board.turn_count % 2 == 0 ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.find do |win|
            @board.cells[win[0]] == @board.cells[win[1]] && 
            @board.cells[win[1]] == @board.cells[win[2]] &&
            (@board.cells[win[0]] == "X" || @board.cells[win[0]] == "O")
        end
    end

    def draw?
        @board.full? && !won?
    end


    def winner
        if win_combo = won?
        @winner = @board.cells[win_combo.first]
        #binding.pry
        end
    end

    def over?
        draw? || won?
    end

    def turn
        @user_input = current_player.move(@board)
        if @board.valid_move?(@user_input)
            @board.update(@user_input, current_player)
        else puts "Please enter a number 1-9"
             turn
        end
        @board.display
    end

    def play
       turn until won? || over?
       if won?
            puts "Congratulations #{winner}!"
        else draw?
            puts "Cat's Game!"
       end
    end

end

