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
        welcome_player
      end
    end

    private

    def show_instructions
      puts 'Here is how to play...'
    end

    def welcome_player
      puts ''
      puts 'Welcome to MASTERMIND'
      puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
      print '> '
    end

    def play
      game = Mastermind::Game.new

      puts 'I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.'

      while true do
        print "What's your guess? "
        response = gets
        case response
          when 'q'
            break
          else
            if too_short?(response)
              puts 'Guess is too short, must be 4 characters'
            elsif too_long?(response)
              puts 'Guess is too long, must be 4 characters'
            else
              if game.correct_guess?(response)
                puts 'That is right!'
                break
              else
                puts 'Sorry, Charlie!'
              end
            end
        end
      end

      puts "The correct answer was '#{game.code}'. See ya!"
    end

    def too_short?(guess)
      guess.length < Mastermind::Game::CODE_SIZE
    end

    def too_long?(guess)
      guess.length > Mastermind::Game::CODE_SIZE
    end

    def puts(message)
      @output.puts message
    end

    def print(message)
      @output.print message
    end

    def gets
      @input.gets.chomp
    end
  end
end
