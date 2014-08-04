require 'mastermind/game.rb'

module Mastermind
  describe Game do
    it 'should have a beginner code of 4 colors' do
      code = Game.new.code

      expect(code.is_a?(String)).to eq(true)
      expect(code.length).to eq(4)
    end

    it 'should seem to randomly generate colors' do
      100.times.collect {
        Game.new.code
      }.uniq.length.should > 1
    end

    it 'should tell the user if s/he guesses wrong' do
      game = Game.new('rgby')
      expect(game.correct_guess?('ybgr')).to eq(false)
    end

    it 'should tell the user if s/he guesses right' do
      game = Game.new('rgby')
      expect(game.correct_guess?('rgby')).to eq(true)
    end

    it 'should allow mixed case guesses' do
      game = Game.new('RGBY')
      expect(game.correct_guess?('rgby')).to eq(true)
    end

    describe 'guessing colors' do
      it 'should give the number of correct colors when there is one match' do
        game = Game.new('rgby')
        expect(game.correct_colors('rrrr')).to eq(1)
      end

      it 'should give the number of correct colors when all match' do
        game = Game.new('rgby')
        expect(game.correct_colors('ybgr')).to eq(4)
      end

      context 'when guess contains multiples' do
        it 'should only give one letter correct' do
          game = Game.new('rgby')

          expect(game.correct_colors('rrrr')).to eq(1)
        end
      end

      context 'when code contains multiples' do
        it 'should only give one letter correct' do
          game = Game.new('rrrr')
          expect(game.correct_colors('rgby')).to eq(1)
        end
      end

      context 'when code and guess have multiple matches' do
        it 'should count them correctly' do
          game = Game.new('rrby')
          expect(game.correct_colors('rrrr')).to eq(2)
        end
      end

      it 'should be case insensitive' do
        game = Game.new('rgby')
        expect(game.correct_colors('YBGR')).to eq(4)
      end
    end

    describe 'guessing location' do
      it 'should not count incorrect locations' do
        game = Game.new('rggg')
        expect(game.correct_locations('bbbr')).to eq(0)
      end

      it 'should count correct locations' do
        game = Game.new('rggg')
        expect(game.correct_locations('rbbb')).to eq(1)
      end

      it 'should count duplicates as only one correct location' do
        game = Game.new('rggg')
        expect(game.correct_locations('rrrr')).to eq(1)
      end
    end
  end
end