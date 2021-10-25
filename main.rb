class Knight
  attr_accessor :child_nodes, :parent_node, :move

  def initialize(move)
    @move = move
    @child_nodes = []
    @parent_node = nil
  end
end

class Game
  attr_accessor :board, :knight_tree, :knight_moves, :move

  def initialize(move, end_move)
    @move = move
    @end_move = end_move
    @board = (0..7).to_a.product((0..7).to_a)
    @board.delete(@move)
    @knight_tree = make_knights
  end

  def possible_moves(move)
    moves = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    moves.map { |i, j| @board.delete([i + move[0], j + move[1]]) }.compact
  end

  def make_knights
    knight = Knight.new(@move)
    queue = [knight]
    until @board.empty? || queue.empty?
      next_knight = queue.shift
      possible_moves(next_knight.move).each do |move|
        k = Knight.new(move)
        k.parent_node = next_knight
        next_knight.child_nodes.push(k)
        queue.push(k)
      end
      moves(next_knight) if next_knight.move == @end_move
    end
    knight
  end

  def moves(node)
    move = []
    until node.nil?
      move.push(node.move)
      node = node.parent_node
    end
    @knight_moves = move.reverse
  end
end

def knight_moves(start_move, end_move)
  Game.new(start_move, end_move).knight_moves
end

p knight_moves([0,0],[1,2])
p knight_moves([0,0],[3,3])
p knight_moves([3,3],[0,0])
p knight_moves([3, 3], [4, 3])
