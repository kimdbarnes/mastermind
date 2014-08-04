module Mastermind
  class Game
    attr_reader :code

    CODE_SIZE = 4

    def initialize(code = nil)
      @code = code || CODE_SIZE.times.collect { 'rgby'.chars.sample }.join
    end

    def correct_guess?(guess)
      guess.downcase == code.downcase
    end

    def correct_colors(guess)
      normalize_and_sort(guess).zip(normalize_and_sort(code)).select { |a,b| a == b }.length
    end

    def correct_locations(guess)
      normalize(guess).zip(normalize(code)).select { |a,b| a == b }.length
    end

    private

    def normalize_and_sort(text)
      normalize(text).sort
    end

    def normalize(text)
      text.downcase.chars
    end
  end
end