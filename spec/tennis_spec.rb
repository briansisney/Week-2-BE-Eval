require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../tennis'

describe Tennis::Game do
  let(:game) { Tennis::Game.new }

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
    it 'calls deuce'do
      3.times {game.wins_point(game.player1)
      game.wins_point(game.player2)}
      expect(game.call_score).to eq("deuce")
    end
  end
end

describe Tennis::Player do
  let(:player) do
    player = Tennis::Player.new
    player.opponent = Tennis::Player.new

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