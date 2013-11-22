module Tennis
  class Game
    attr_accessor :player1, :player2

    def initialize
      @player1 = Player.new(server: true)
      @player2 = Player.new(server: false)

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    def wins_point(winner)
      winner.add_point
    end

    def call_score
      if player1.points == player2.points
        tie
      elsif player1.server == true
        "#{@player1.score} #{@player2.score}"
      else
        "#{@player2.score} #{@player1.score}" 
      end 
    end

    def tie
      return "fifteen-all" if player1.points == 1
      return "thirty-all" if player1.points == 2
      return "deuce" if player1.points == 3
    end


  end

  class Player
    attr_accessor :points, :opponent, :server

    def initialize(server: true)
      @points = 0
      @server = server
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