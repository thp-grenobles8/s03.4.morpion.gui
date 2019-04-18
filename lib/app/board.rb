class Board
  attr_reader :data, :index, :game, :size

  def initialize
    @players_signature = {}
  end

  def setup (size = 3)
    @index = {:rows => {}, :cols => {}}
    @data = []
    @size = size
    size.times {
      row = []
      size.times {
        row << Cell.new.link_to_board(self)
        @index[:cols][('A'..'Z').to_a[row.length - 1]] = row.length -  1
      }
      @data << row
      @index[:rows][@data.length] = @data.length - 1
    }
    self
  end

  def link_to_game (game)
    @game = game
    self
  end

  def render
    put_slow col_line
    for ix in 0..(@data.length-1)
      put_slow v_line
      put_slow cell_line(ix)
    end
    put_slow v_line
  end

  def col_line
    rendered = " "*@game.graphics[:indent]
    for col in @index[:cols].keys
      rendered += "  " + col + " "
    end
    rendered
  end

  def v_line
    rendered = " "*@game.graphics[:indent]
    @size.times {
      rendered += @game.graphics[:corner] +
        @game.graphics[:horizontal]*3
    }
    rendered += @game.graphics[:corner]
    rendered
  end

  def cell_line (ix)
    rendered = " "*(@game.graphics[:indent]-2) +
      @index[:rows].key(ix).to_s + ' '
    for cell in @data[ix]
      rendered += @game.graphics[:vertical] + " " +
        cell.render.bold.blue + " "
    end
    rendered += @game.graphics[:vertical]
    rendered
  end

  def set (coord, player)
    get(coord).set(player)
  end

  def get (coord)
    col = parse_col(coord)
    row = parse_row(coord).to_i
    @data[@index[:rows][row]][@index[:cols][col]]
  end

  def get_0 (row, col)
    @data[row][col]
  end

  def parse_col (coord)
    cols = coord.scan(/[a-zA-Z]/)
    if cols.length != 1
      raise "Coordonnées invalides ! UNE lettre et UNE SEULE !"
    elsif !@index[:cols].keys.include?(cols[0].upcase)
      raise "Coordonnées invalides ! #{cols[0]} n'est pas une collone !"
    end
    cols[0].upcase
  end

  def parse_row (coord)
    rows = coord.scan(/[0-9]+/)
    if rows.length != 1
      raise "Coordonnées invalides ! trop de lettres !"
    elsif !@index[:rows].keys.include?(rows[0].to_i)
      raise "Coordonnées invalides ! #{rows[0]} n'est pas une ligne !"
    end
    rows[0]
  end

  def to_s
    "<Board size=#{@size}>"
  end
end
