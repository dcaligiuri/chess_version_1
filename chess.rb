class Board 
	
	attr_accessor :postition, :board 
	
    def initialize
    	arr = []
    	8.times { arr << ([nil] * 8)}
    	@board = arr 
    end
    
    def board 
    	@board
    end 
    
    def empty?(square)
    	if self.board[square[0]][square[1]] != nil 
    		return false
    	end 
    end
    
    
    def setup
    	arr = []
    	rook1 = Rook.new([0,0])
    	knight1 = Knight.new([1,0])
    	bishop1 = Bishop.new([2,0])
    	queen = Queen.new([3,0])
    	king = King.new([4,0])
    	bishop2 = Bishop.new([5,0])
    	knight2 = Knight.new([6,0])
    	rook2 = Rook.new([7,0])
    	arr.push(rook1,knight1,bishop1,queen,king,bishop2,knight2,rook2)
    	arr.each {|element| self.put_on_board(element)}
    	arr = []
    	b_rook1 = Rook.new([0,7])
    	b_knight1 = Knight.new([1,7])
    	b_bishop1 = Bishop.new([2,7])
    	b_queen = Queen.new([3,7])
    	b_king = King.new([4,7])
    	b_bishop2 = Bishop.new([5,7])
    	b_knight2 = Knight.new([6,7])
    	b_rook2 = Rook.new([7,7])
    	arr.push(b_rook1,b_knight1,b_bishop1,b_queen,b_king,b_bishop2,b_knight2,b_rook2)
    	arr.each {|element| self.put_on_board(element)}
    	self.board.each_with_index do |row,index1|
    		row.each_with_index do |element, index2|
    			if index2 == 1 || index2 == 6
    				self.put_on_board(Pawn.new([index1,index2]))
    			end 
    		end 
    	end 
    			
   
    end 
   
    
    def display_board
    	printed_board = []
    	@board.each do |row|
    		row.each do |element|
    			if element.is_a?(Pawn)
    				element = :P
    			elsif element.is_a?(King)
    				element = :K 
    			elsif element.is_a?(Queen)
    				element = :Q 
    			elsif element.is_a?(Knight)
    				element = :N 
    			elsif element.is_a?(Bishop)
    				element = :B 
    			elsif element.is_a?(Rook)
    				element = :R 
    			end 
    			printed_board << element 
    		end 
    	end 
    	printed_board = printed_board.each_slice(8).to_a
    	printed_board.each do |rows|
    		puts rows.to_s 
    	end 
    end 
    
    
    def put_on_board(piece)
    	@board[piece.postition[0]][piece.postition[1]] = piece 
    end 
   

end 

class Piece 
	
	attr_accessor :board 
	
	def initialize(postition) 
		@postition = postition
	end 
	
	def postition 
		@postition
	end 	
	
	def move(board,space_arr)
		@postition = space_arr
		board.board.each do |row|
			row.collect! do |element|
				element == self ? nil : element 
			end 
		end 
		board.board[@postition[0]][@postition[1]] = self 
	end 

end 

class Pawn < Piece 
	
	def move(board, space_arr)
		@postition = space_arr
		board.board.each do |row|
			row.collect! do |element|
				element == self ? nil : element 
			end 
		end 
		board.board[@postition[0]][@postition[1]] = self 
	end 
	
	def valid_move?(board, square)
		return false if board.empty?(square) == false
	end 

end 

class King < Piece 	


end 

class Bishop < Piece 

end 
	
	

class Knight < Piece 
	
	
end 

class Rook < Piece 


end 

class Queen < Piece 


end 

class Player 
	
	def which_piece?
		puts "Where is the piece you want to move?"
		piece_position = gets.chomp
		piece_position_arr = piece_position.split(",")
		piece_position_arr.map {|element| element.to_i } 
	end 
	
	def to_where? 
		puts "Where do you want to move it?"
		move_string = gets.chomp 
		move_arr = move_string.split(",")
		move_arr.map { |element| element.to_i }
	end 
end

class Game 
	
	attr_accessor :current_player
	
	def initialize(player1, player2, board)
		@player1 = player1 
		@player2 = player2 
		@board = board 
		@current_player = player1 
	end 
	
	def current_player
		@current_player 
	end 
	
	def setup
		@board.setup
	end 
	
	
	def board 
		@board 
	end 
	
	def switch_players!
		if current_player == @player1 
			@current_player = @player2 
		elsif current_player == @player2 
			@current_player = @player1 
		end 
	end 
	
	
	def play 
		on = "go"
		board.display_board
		while on 
			postition_of_piece = current_player.which_piece?
			move_to_square = current_player.to_where?
			piece_to_move = self.board.board[postition_of_piece[0]][postition_of_piece[1]]
			piece_to_move.move(self.board, move_to_square)
			board.display_board 
			switch_players!
		end 
	end 
	
	
end 


player1 = Player.new
player2 = Player.new 
board = Board.new 
game = Game.new(player1, player2, board)
game.setup
game.play


