class Player
  attr_reader :id, :symbol, :game

  def initialize (id)
    @id = id
    choose_symbol
    self
  end

  def choose_symbol
    put_slow "JOUEUR #{id} -- quel symbole ?".bold.blue
    choice = nil
    choices = {1=> "O" ,2=> "X" , 3=> '🤪' ,4=> '✓' ,5=> '🤮', 6=> '💩' }
    until choices.include?(choice)
      print choices
      puts ""
      print "tapez l'index de votre choix >"
      choice = gets.chomp.to_i
    end
    @symbol = choices[choice]
    puts ''
    self
  end

  def link_to_game (game)
    @game = game
    self
  end

  def play_cell (coord)
    begin
      @game.board.set(coord, self)
      true
    rescue => error
      put_slow error
      false
    end
  end

  def play
    put_slow "  #{@symbol}  " + "JOUEUR #{@id} ---".bold.blue
    played = false
    until played
      put_slow "tapez \"voir\" ou la coordonnée d'une case a jouer".italic
      print '>>'
      value = gets.chomp.to_s
      if value == 'voir'
        @game.see
        played = false
      else
        played = play_cell(value)
      end
    end
    put_slow ''
  end

end
