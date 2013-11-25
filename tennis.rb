module Tennis
  class Game
    attr_accessor :player1, :player2

    def initialize(name1, name2)
      @player1 = Player.new(name1, self, server: true)
      @player2 = Player.new(name2, self, server: false)

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    def wins_point(winner)
      if winner.points == 4 
        winner.add_game
        clear_score
        change_server
      elsif reverse_advantage?(winner)
        winner.opponent.subt_pt
      else
        winner.add_point
      end
    end
    
    #score calls the points, not games or sets
    def call_score
      if @player1.points == @player2.points
        tie_score
      elsif advantage?
        advantage 
      else 
        "#{current_server.score} #{current_server.opponent.score}"
      end
    end
    
    def call_game
      "#{player1.name}: #{player1.games_won} #{player2.name}: #{player2.games_won}"
    end

    def won_by_two?
      (player1.games_won-player2.games_won).abs == 2
    end

    private
    def clear_score
      @player1.points = 0
      @player2.points = 0
    end
    def tie_score
      return "fifteen-all" if @player1.points == 1
      return "thirty-all" if @player1.points == 2
      return "deuce" if @player1.points == 3
    end
    def advantage
      current_server.points > current_server.opponent.points ? "Ad In" : "Ad Out"
    end
    def advantage?
      (@player1.points + @player2.points) > 6
    end
    def current_server
      @player1.server ? @player1 : @player2
    end
    def reverse_advantage?(winner)
      winner.points == 3 && winner.opponent.points == 4
    end 
    def change_server
       if player1.server == true
         player1.server = false
         player2.server = true
       else
         player1.server = true
         player2.server = false
       end
    end 
  end

  class Player

    attr_accessor :name, :points, :opponent, :server, :games_won, :sets_won

    def initialize(name, game, server: true)
      @points = 0
      @server = server
      @name = name
      @games_won = 0
      @sets_won = 0
      @game = game
    end
    def add_game
      @games_won += 1
      if @games_won > 5 && @game.won_by_two?
        add_set
        @games_won, @opponent.games_won = 0, 0
      end
    end
    def add_set
      @sets_won += 1
    end
    def add_point
      @points += 1
    end
    def subt_pt
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