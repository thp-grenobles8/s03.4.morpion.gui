class Index
  def perform
    put_slow '---------------------------'
    put_slow '--   Bienvenue     au    --'
    put_slow '--      MAXI MORPION     --'
    put_slow '---------------------------'
    puts ''
    puts ''
    stop = false
    count = 0
    until stop
      put_slow "Voulez vous #{count>0?"re-":""}jouer au maxi-morpion ?"
      print '"o" pour OUI>>'
      r = gets.chomp.to_s
      if r == "o"
        put_slow "D'accord ! c'est parti !!"
        put_slow ''
        put_slow '--------------------------'
        put_slow ''
        game = Game.new.play
        count += 1
      else
        put_slow ''
        put_slow '--------------------------'
        put_slow ''
        put_slow "Ooooh déjà ? vous avez fait #{count} parties"
        stop = true
      end
    end
  end
end
