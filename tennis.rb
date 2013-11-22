module Tennis
  class Game
    attr_accessor :player1, :player2

    def initialize(name1, name2)
      @player1 = Player.new(name1, server: true)
      @player2 = Player.new(name2, server: false)

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    def wins_point(winner)
      winner.add_point
    end

    def call_score
      if @player1.points == @player2.points
        tie_score
      elsif (@player1.points + @player2.points) > 6
        deuce 
      elsif @player1.server
        "#{@player1.score} #{@player2.score}"
      else
        "#{@player2.score} #{@player1.score}"
      end
    end

    private
    def tie_score
      return "fifteen-all" if player1.points == 1
      return "thirty-all" if player1.points == 2
      return "deuce" if player1.points == 3
    end
    def deuce
      if player1.server
        player1.points>player2.points ? "Ad In" : "Ad Out"
      else
        player2.points>player1.points ? "Ad In" : "Ad Out"
      end
    end
    
  end

  class Player
    attr_accessor :name, :points, :opponent, :server

    def initialize(name, server: true)
      @points = 0
      @server = server
      @name = name
    end

    def add_point
      @points += 1
    end

    def subtract_point
      @points -= 1
    end

    def score
      return 'love' if @points == 0
      return 'fifteen' if @points == 1
      return 'thirty' if @points == 2
      return 'forty' if @points == 3
      return 'advantage' if @points == 4
    end
  end
end