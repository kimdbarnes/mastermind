require 'mastermind/game.rb'

module Mastermind
  describe Game do
    it 'should have a beginner code of 4 colors' do
      code = Game.new.code

      code.should be_a String
      code.length.should == 4
    end

    it 'should seem to randomly generate colors' do
      100.times.collect {
        Game.new.code
      }.uniq.length.should > 1
    end

    it 'should tell the user if s/he guesses wrong' do
      game = Game.new('rgby')
      game.correct_guess?('ybgr').should be_false
    end

    it 'should tell the user if s/he guesses right' do
      game = Game.new('rgby')
      game.correct_guess?('rgby').should be_true
    end

    it 'should allow mixed case guesses' do
      game = Game.new('RGBY')
      game.correct_guess?('rgby').should be_true
    end

    describe 'guessing colors' do
      it 'should give the number of correct colors when there is one match' do
        game = Game.new('rgby')
        game.correct_colors('rrrr').should == 1
      end

      it 'should give the number of correct colors when all match' do
        game = Game.new('rgby')
        game.correct_colors('ybgr').should == 4
      end

      context 'when guess contains multiples' do
        it 'should only give one letter correct' do
          game = Game.new('rgby')
          game.correct_colors('rrrr').should == 1
        end
      end

      context 'when code contains multiples' do
        it 'should only give one letter correct' do
          game = Game.new('rrrr')
          game.correct_colors('rgby').should == 1
        end
      end

      context 'when code and guess have multiple matches' do
        it 'should count them correctly' do
          game = Game.new('rrby')
          game.correct_colors('rrrr').should == 2
        end
      end

      it 'should be case insensitive' do
        game = Game.new('rgby')
        game.correct_colors('YBGR').should == 4
      end
    end
  end
end