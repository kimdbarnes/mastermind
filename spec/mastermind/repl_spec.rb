require 'mastermind/repl.rb'
require 'mastermind/game.rb'

module Mastermind
  describe Repl do

    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:welcome_message_parts) do
      [
        '',
        'Welcome to MASTERMIND',
        'Would you like to (p)lay, read the (i)nstructions, or (q)uit?',
        '> '
      ]
    end

    it 'should be' do
      Repl.new.should be
    end

    it 'should give opening message' do
      input.puts 'q'
      input.rewind

      Repl.new(output, input).run

      to_array(output)[0..4].should == welcome_message_parts
    end

    it 'should quit' do
      input.puts 'q'
      input.rewind

      Repl.new(output, input).run
    end

    it 'should read user input' do
      input = StringIO.new
      input.puts 'p'
      input.puts 'q'
      input.puts 'q'
      input.rewind

      Repl.new(output, input).run
    end

    it 'should print instructions' do
      input.puts 'i'
      input.puts 'q'
      input.rewind

      Repl.new(output, input).run

      to_array(output).include?('> Here is how to play...').should be_true
    end

    describe 'playing the game' do
      it 'should tell the player when they guess right' do
        input.puts 'p'
        input.puts 'rrrr'
        input.puts 'q'
        input.puts 'q'
        input.rewind

        game = double('game')
        game.should_receive(:correct_guess?).with('rrrr').and_return(true)
        game.stub(:code)
        Mastermind::Game.should_receive(:new).and_return(game)

        Repl.new(output, input).run

        contains_message?(output, 'That is right!').should be_true
      end

      it 'should tell the player if they guess wrong' do
        input.puts 'p'
        input.puts 'rrrr'
        input.puts 'q'
        input.puts 'q'
        input.rewind

        game = double('game')
        game.stub(:correct_guess?).with('rrrr').and_return(false)
        game.stub(:code)
        Mastermind::Game.should_receive(:new).and_return(game)

        Repl.new(output, input).run

        contains_message?(output, 'Sorry, Charlie!').should be_true
      end

      it 'should keep playing until the user quits' do
        input.puts 'p'
        10.times do
          input.puts 'rrrr'
        end
        input.puts 'q'
        input.puts 'q'
        input.rewind

        game = double('game')
        game.should_receive(:correct_guess?).exactly(10).times.with('rrrr').and_return(false)
        game.stub(:code)
        Mastermind::Game.should_receive(:new).and_return(game)

        Repl.new(output, input).run

        contains_message?(output, 'See ya!').should be_true
      end

      it 'should give error if guess is too short' do
        input.puts 'p'
        input.puts 'r'
        input.puts 'q'
        input.puts 'q'
        input.rewind

        Repl.new(output, input).run

        contains_message?(output, 'Guess is too short, must be 4 characters').should be_true
      end

      it 'should give error if guess is too long' do
        input.puts 'p'
        input.puts 'rrrrr'
        input.puts 'q'
        input.puts 'q'
        input.rewind

        Repl.new(output, input).run

        contains_message?(output, 'Guess is too long, must be 4 characters').should be_true
      end
    end

    def to_array(output)
      output.string.split("\n")
    end

    def contains_message?(output, message)
      to_array(output).any? {|output_line| output_line.include?(message) }
    end
  end
end