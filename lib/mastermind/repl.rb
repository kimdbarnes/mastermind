module Mastermind
  class Repl
    def initialize(output = STDOUT, input = STDIN)
      @output = output
      @input = input
    end

    def run
      welcome_player

      while (command = gets) != 'q' do
        case command
          when 'i'
            show_instructions
          when 'p'
            play
        end
      end
    end

    private

    def show_instructions
      puts 'Here is how to play...'
    end

    def welcome_player
      puts 'Welcome to MASTERMIND'
      puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
      puts '>'
    end

    def play
      game = Mastermind::Game.new

      puts 'I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.'

      while (response = gets) != 'q' do
        puts "What's your guess?"
        puts (game.correct_guess?(response) ? 'That is right!' : 'Sorry, Charlie!')
      end

      puts 'See ya!'
    end

    def puts(message)
      @output.puts message
    end

    def gets
      @input.gets.chomp
    end
  end
end
