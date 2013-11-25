require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../tennis'

describe Tennis::Game do
  let(:game) { Tennis::Game.new("Brian","Alex") }

  describe '.initialize' do
    it 'creates two players' do
      expect(game.player1).to be_a(Tennis::Player)
      expect(game.player2).to be_a(Tennis::Player)
    end

    it 'sets the opponent for each player'do
      expect(game.player1.opponent).to eq(game.player2)
      expect(game.player2.opponent).to eq(game.player1)
    end
    it 'sets player to server and player2 to server false'do
      expect(game.player1.server).to eq(true)
      expect(game.player2.server).to eq(false)
    end

  end

  describe '#wins_point' do
    it 'increments the points of the winning player' do
      game.wins_point(game.player1)
      # game.wins_point(@player1)
      expect(game.player1.points).to eq(1)
    end
    context 'when game is won' do
      it 'returns game one' do
        5.times {game.wins_point(game.player1)} 
        expect(game.player1.games_won).to eq(1)
      end
      it 'clears player1 points'do
        5.times {game.wins_point(game.player1)} 
        expect(game.player1.points).to eq(0)
      end
      it 'changes server'do
        5.times {game.wins_point(game.player1)} 
        expect(game.player1.server).to eq(false)
      end
    end
    
    
  end

  describe '#call_score' do
    it 'calls both players scores if scores uneven'do
      game.wins_point(game.player1)
      expect(game.call_score).to eq("fifteen love")
    end
    it 'calls both players scores if even'do
      2.times {game.wins_point(game.player1)
      game.wins_point(game.player2)}
      expect(game.call_score).to eq("thirty-all")
    end
    it 'it calls deuce' do
      3.times do 
        game.wins_point(game.player1)
        game.wins_point(game.player2)
      end
      expect(game.call_score).to eq("deuce")
    end
    it 'it calls Ad In' do
      3.times do 
        game.wins_point(game.player1)
        game.wins_point(game.player2)
      end
      game.wins_point(game.player1)
      expect(game.call_score).to eq("Ad In")
    end
    it 'it calls back deuce after ad in' do
      4.times do 
        game.wins_point(game.player1)
        game.wins_point(game.player2)
      end
      expect(game.call_score).to eq("deuce")
    end
  end

  describe '#call_game' do
    it 'calls the games score 0-0 at start'do
      expect(game.call_game).to eq("Brian: 0 Alex: 0")
    end
    it 'calls the games score 1-0 after first game'do
      5.times {game.wins_point(game.player1)} 
      expect(game.call_game).to eq("Brian: 1 Alex: 0")
    end
    it 'calls the games score 5-5'do
      25.times {game.wins_point(game.player1)}
      25.times {game.wins_point(game.player2)} 
      expect(game.call_game).to eq("Brian: 5 Alex: 5")
    end
    it 'does not call the games score 6-4, but 0-0'do
      20.times {game.wins_point(game.player1)}
      20.times {game.wins_point(game.player2)}
      10.times {game.wins_point(game.player1)}
      expect(game.call_game).to eq("Brian: 0 Alex: 0")
      #set isn't working or rather clear score isn't working
    end
    it 'calls the set score 1'do
      20.times {game.wins_point(game.player1)}
      20.times {game.wins_point(game.player2)}
      10.times {game.wins_point(game.player1)}
      expect(game.player1.sets_won).to eq(1)
    end
    it 'calls the game score 6-5'do
      25.times {game.wins_point(game.player1)}
      25.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      expect(game.call_game).to eq("Brian: 6 Alex: 5")
    end
    it 'calls the game score 7-6'do
      25.times {game.wins_point(game.player1)}
      25.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      5.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      expect(game.call_game).to eq("Brian: 7 Alex: 6")
    end
    it 'calls the game score 8-7'do
      25.times {game.wins_point(game.player1)}
      25.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      5.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      5.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      expect(game.call_game).to eq("Brian: 8 Alex: 7")
    end
    it 'calls the game score 0-0'do
      25.times {game.wins_point(game.player1)}
      25.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      5.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      5.times {game.wins_point(game.player1)}
      expect(game.call_game).to eq("Brian: 0 Alex: 0")
    end
    it 'calls the set equal to 1'do
      25.times {game.wins_point(game.player1)}
      25.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      5.times {game.wins_point(game.player2)}
      5.times {game.wins_point(game.player1)}
      5.times {game.wins_point(game.player1)}
      expect(game.player1.sets_won).to eq(1)
    end
  end
end
# so when calling self on game, is this okay to do? would it have been better to take and done the game compare in players? or is it fine to call self? 
describe Tennis::Player do
  let(:player) do
    player = Tennis::Player.new("Name", Tennis::Game.new("Brian","Alex") )
    player.opponent = Tennis::Player.new("Name2", Tennis::Game.new("Brian","Alex"))

    return player
  end

  describe '.initialize' do
    it 'sets the points to 0' do
      expect(player.points).to eq(0)
    end 
  end

  describe '#add_point' do
    it 'increments the points' do
      player.add_point

      expect(player.points).to eq(1)
    end
  end

  describe '#score' do
    context 'when points is 0' do
      it 'returns love' do
        expect(player.score).to eq('love')
      end
    end
    
    context 'when points is 1' do
      it 'returns fifteen' do
        player.points = 1

        expect(player.score).to eq('fifteen')
      end 
    end
    
    context 'when points is 2' do
      it 'returns thirty' do
        player.points = 2

        expect(player.score).to eq('thirty')
      end 
    end
    
    context 'when points is 3' do
      it 'returns forty' do
        player.points = 3

        expect(player.score).to eq('forty')
      end
    end
  end
end