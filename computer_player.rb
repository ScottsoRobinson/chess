class ComputerPlayer

  attr_reader :color

  def initialize(board)
    @color = :b
    @board = board
  end

  def play_turn

    @possible = possible_moves
    @safe_moves = safe_moves
    return checkmate_moves.first unless checkmate_moves.empty?




    # if duped_board.in_check?(:w) && possible_attacks.include?(move)
    #   check_attacks << move
    # elsif duped_board.in_check?(:w)
    #   checks << move
    # end



    #return (check_moves & attack_moves & safe_moves).sample unless (check_moves & attack_moves & safe_moves).empty?
    puts "trying attack and safe"
    return (attack_moves & safe_moves).sample unless (attack_moves & safe_moves).empty?

    puts "trying intersection"
    return (check_moves & good_trade).sample unless (check_moves & good_trade).empty?
    puts "past intersection, trying highest and good"
    p attack_moves
    p 0
    p highest_attack_moves
    p 1
    p good_trade
    p 2
    p attack_moves
    p 3
    return (good_trade & highest_attack_moves).sample unless (highest_attack_moves & good_trade).empty?
    puts "past highest and good, trying good"

    return good_trade.sample unless good_trade.empty?
    puts "trying safe"
    return safe_moves.sample unless safe_moves.empty?
    puts "past good, trying check"
    return check_moves.sample unless check_moves.empty?
    puts "past check, trying highest"
    return highest_attack_moves.sample unless highest_attack_moves.empty?
    puts "past highest, trying attack"
    return attack_moves.sample unless attack_moves.empty?
    puts "past attack, trying possible"

    possible_moves.sample

  end

  def check_moves
    check_moves = []
    puts "in check moves"
    @possible.each do |move|
      duped_board = @board.dup
      duped_board.move(move[0],move[1])
      if duped_board.in_check?(:w)
        check_moves << move
      end
    end
    p check_moves
    check_moves

  end
  def checkmate_moves
    @possible.each do |move|

      duped_board = @board.dup
      duped_board.move(move[0],move[1])

      return move if duped_board.checkmate?(:w)
    end
    []

  end


  def possible_moves
    possible_moves = []

    @board.collect_pieces(color).each do |piece|
      piece.valid_moves.each {|move| possible_moves << [piece.position, move] }
    end

    possible_moves
  end

  def safe_moves
    safe_moves = []

    @possible.each do |move|
      duped_board = @board.dup
      duped_board.move(move[0],move[1])
      opponent_color = color == :w ? :b : :w
      all_possible_moves = []

      duped_board.collect_pieces(opponent_color).each do |piece|
        all_possible_moves += piece.valid_moves
      end

      unless all_possible_moves.include?(move[1])
        safe_moves << move
      end
    end
    safe_moves
  end


  def good_trade


    puts "in good trade"
    good_trades = attack_moves.select do |move|
      p move
      @board[move[1]].class::VALUE >= @board[move[0]].class::VALUE
    end
    good_trades = [] if good_trades.nil?
    p good_trades
    good_trades
  end

  def attack_moves

    possible_attacks = @possible.select do |move|
      !@board[move[1]].nil?
    end
    possible_attacks = [] if possible_attacks.nil?
    possible_attacks.sort! {|m1, m2| @board[m2[1]].class::VALUE <=> @board[m1[1]].class::VALUE}


  end

  def highest_attack_moves
    highest = []
    if !attack_moves.empty?
      best_val = @board[attack_moves.first[1]].class::VALUE
      highest = attack_moves.select {|move| @board[move[1]].class::VALUE == best_val }
    end
    highest
  end



end
