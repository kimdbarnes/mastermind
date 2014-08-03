require 'mastermind/repl.rb'
require 'mastermind/game.rb'

module Mastermind
  describe Repl do

    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:welcome_message_parts) do
      [
        'Welcome to MASTERMIND',
        'Would you like to (p)lay, read the (i)nstructions, or (q)uit?',
        '>'
      ]
    end

    it 'should be' do
      Repl.new.should be
    end

    it 'should give opening message' do
      input.puts 'q'
      input.rewind

      Repl.new(output, input).start

      to_array(output)[0..2].should == welcome_message_parts
    end

    it 'should quit' do
      input.puts 'q'
      input.rewind

      Repl.new(output, input).start
    end

    it 'should read user input' do
      input = StringIO.new
      input.puts 'p'
      input.puts 'q'
      input.rewind

      Repl.new(STDOUT, input).start
    end

    it 'should print instructions' do
      input.puts 'i'
      input.puts 'q'
      input.rewind

      Repl.new(output, input).start

      to_array(output).last.should == 'Here is how to play...'
    end

    it 'should loop' do
      times_to_loop = 15

      times_to_loop.times do
        input.puts 'i'
      end
      input.puts 'q'
      input.rewind

      Repl.new(output, input).start

      to_array(output).length.should == times_to_loop + welcome_message_parts.size
    end

    describe 'playing the game' do
      it 'should play a game' do
        input.puts 'p'
        input.puts 'r'
        input.puts 'q'
        input.rewind

        game = double('game')
        game.should_receive(:correct_guess?).with('r').and_return(true)
        Mastermind::Game.should_receive(:new).and_return(game)

        Repl.new(output, input).start

        to_array(output)[-3..-1].should == [
          'I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.',
          "What's your guess?",
          'That is right!'
        ]
      end

      it 'should keep playing until the user quits' do
        input.puts 'p'
        10.times do
          input.puts 'r'
        end
        input.puts 'q'
        input.puts 'q'
        input.rewind

        game = double('game')
        game.should_receive(:correct_guess?).exactly(10).times.with('r').and_return(false)
        Mastermind::Game.should_receive(:new).and_return(game)

        Repl.new(output, input).start

        to_array(output).length.should == 16
        to_array(output).last.should == 'See ya!'
      end

      it 'should give error if guess is too short'
      it 'should give error if guess is too long'
    end

    def to_array(output)
      output.string.split("\n")
    end
  end
end