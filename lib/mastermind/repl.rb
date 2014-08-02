module Mastermind
  class Repl
    def initialize(output = STDOUT, input = STDIN)
      @output = output
      @input = input
    end

    def start
      _welcome_player

      while (command = _gets) != 'q' do
        case command
          when 'i'
            _show_instructions
          when 'p'
            _play
        end
      end
    end

    private

    attr_reader :output, :input

    def _show_instructions
      _puts 'Here is how to play...'
    end

    def _welcome_player
      _puts 'Welcome to MASTERMIND'
      _puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
      _puts '>'
    end

    def _play
      game = Mastermind::Game.new

      _puts 'I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.'
      _puts "What's your guess?"

      while (response = _gets) != 'q' do
        correct = game.correct_guess?(response)
        if correct
          _puts 'That is right!'
        end
        _puts "What's your guess?"
      end

      _puts 'See ya!'
    end

    def _puts(message)
      output.puts message
    end

    def _gets
      input.gets.chomp
    end
  end
end
