# frozen_string_literal: true

module Hangman

  # Interact with the player
  class Player
    attr_reader :guess, :wrong_guesses

    def initialize
      @wrong_guesses = []
      @guess = ""
    end

    def new_guess
      guess_message
      loop do
        @guess = gets.chomp.downcase
        puts ""
        evaluate_keywords if guess == "save" || guess == "quit"
        return guess if valid_input?

        guess_message
      end
    end

    def update_wrong_guesses
      wrong_guesses.push(guess)
      wrong_guesses.push(" ")
    end

    def wrong_guesses_string
      wrong_guesses.join
    end

    private

    at_exit do
      puts "Thanks for playing"
    end

    def evaluate_keywords
      guess == "save" ? save_game : exit
    end

    def save_game
      puts "Save game..."
      exit
    end

    def valid_input?
      @guess.length == 1 && @guess =~ /[a-z]{1}/
    end

    def guess_message
      print "Please enter a letter between a - z, save, or quit: "
    end
  end
end
