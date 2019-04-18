class Game
  attr_reader :players, :board, :win
  attr_accessor :graphics

  def initialize
    @graphics = {
      :indent => 5,
      :corner => "+",
      :vertical => "|",
      :horizontal => "-"
    }
  end

  def set_board
    put_slow 'Quelle taille de plateau ?'
    size = nil
    until (1..9).to_a.include?(size) || size == 0
      print "(3 par défaut, 9 max)>"
      size = gets.chomp.to_i
    end
    size = size == 0 ? 3 : size
    put_slow "#{size} cases de long et de large !"
    put_slow ''
    @board = Board.new.setup(size).link_to_game(self)
  end

  def set_win
    put_slow 'Combien de cases pour gagner ?'
    nb = nil
    until (2..@board.size).to_a.include?(nb) || nb == 0
      print "(3 par défaut)>"
      nb = gets.chomp.to_i
    end
    @win = nb == 0 ? 3 : nb
    put_slow "#{@win} cases pour gagner"
    put_slow ''
  end

  def set_players
    put_slow 'Combien de joueurs ?'
    nb = nil
    until (1..4).to_a.include?(nb) || nb == 0
      print "(2 par défaut, 4 max)>"
      nb = gets.chomp.to_i
    end
    nb = nb == 0 ? 2 : nb
    put_slow "#{nb} joueurs"
    put_slow ''
    @players = []
    nb.times { |ix|
      @players << Player.new(ix+1).link_to_game(self)
    }
  end

  def play
    set_board
    set_win
    set_players
    is_over = false
    until is_over
      is_over = round
    end
  end

  def round
    is_over = false
    @players.each { |player|
      break if is_over
      see
      player.play
      is_over = check
    }
    is_over
  end

  def check
    is_over = false
    is_over = is_over || check_rows
    is_over = is_over || check_columns
    #is_over = is_over || check_diag_asc
    #is_over = is_over || check_diag_des
    return is_over
  end

  def check_rows
    full = 0
    @board.data.each { |row|
      player_id = nil
      successive = 0
      fulls = 0
      row.each { |cell|
        cell.status == player_id ? successive += 1 :successive = 1
        fulls += 1 if cell.status != nil
        return over(player_id) if player_id != nil && successive >= @win
        player_id = cell.status
      }
      full += 1 if fulls == row.length
    }
    return over(nil) if full == @board.data.length
    return false
  end

  def check_columns
    @board.index[:cols].values.each { |ix|
      player_id = nil
      successive = 0
      @board.data.each { |row|
        cell = row[ix]
        cell.status == player_id ? successive += 1 : successive = 1

        return over(player_id) if player_id != nil && successive >= @win
        player_id = cell.status
      }
    }
    return false
  end

  def over (winner)
    see
    put_slow "La partie est terminée !".bold.blue
    case winner
    when nil
      put_slow "MATCH NUL..."
    else
      winner = @players[winner-1]
      put_slow "  #{winner.symbol}  " +
        "JOUEUR #{winner.id} a GAGNE !!!".bold.blue
    end
    return true
  end

  def see
    @board.render
    put_slow ''
  end

  def to_s
    return "<Game players =#{@players.length} size=#{@board.size}>"
  end
end
