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
      sort(guess).collect.with_index do |guess_char, i|
        guess_char == sort(code)[i]
      end.select{|match| match}.count
    end

    private

    def sort(text)
      text.downcase.chars.sort
    end
  end
end