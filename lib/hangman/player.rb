# frozen_string_literal: true

module Hangman
  # Interact with the player
  class Player
    attr_reader :guess, :wrong_guesses

    def initialize(wrong_guesses = nil)
      @wrong_guesses = wrong_guesses
      @guess = ""
      _wrong_guesses
    end

    def new_guess
      print "Please enter a letter between a - z, save, or quit: "
      input_guess
      puts ""
      guess
    end

    def update_wrong_guesses
      wrong_guesses.push(guess)
      wrong_guesses.push(" ")
    end

    def wrong_guesses_string
      wrong_guesses.join
    end

    private

    def _wrong_guesses
      @wrong_guesses ||= []
    end

    def input_guess
      loop do
        @guess = gets.chomp.downcase
        break if valid_input?

        print "Please limit your responses to letters between 'a' - 'z', 'save', or 'quit': ".red
      end
    end

    def valid_input?
      (@guess.length == 1 && @guess =~ /[a-z]{1}/) || keywords?
    end

    def keywords?
      guess == "save" || guess == "quit"
    end
  end
end
