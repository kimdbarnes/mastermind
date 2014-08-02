module Mastermind
  class Game
    attr_reader :code

    def initialize(code = nil)
      @code = code || 4.times.collect { 'rgby'.chars.sample }.join
    end

    def correct_guess?(guess)
      guess.downcase == code.downcase
    end

    def correct_colors(guess)
      number_correct = 0
      guess.downcase.chars.sort.each_with_index do |letter, i|
        number_correct = number_correct + 1 if letter == code.chars.sort[i]
      end
      number_correct
    end
  end
end