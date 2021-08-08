# frozen_string_literal: true

module Hangman

  # Tracks the status of the game
  class Game
    attr_reader :secret_word, :cipher, :player

    def initialize(secret_word, cipher, player)
      @secret_word = secret_word
      @cipher = cipher
      @player = player
    end

    def play
      show_cipher
      while player.wrong_guesses.length < allowed_wrong_guesses
        play_one_round
        show_cipher
        break if cipher.solved?

        puts "Wrong guesses: #{player.wrong_guesses_string}\n\n"
      end
    end

    private

    def show_cipher
      puts cipher.show_cipher
    end

    def play_one_round
      player.new_guess
      if keywords.include?(player_guess)
        evaluate_keywords
      elsif word.include?(player_guess)
        cipher.update_cipher(player_guess)
        return
      end
      player.update_wrong_guesses
    end

    at_exit do
      puts "Thanks for playing"
    end

    def evaluate_keywords
      player_guess == "save" ? save_game : exit
    end

    def save_game
      puts "Save game..."
      exit
    end

    def player_guess
      player.guess
    end

    def keywords
      %w[save quit]
    end

    def word
      secret_word.word
    end

    def allowed_wrong_guesses
      # Twice the number of actual wrong guesses to account for the spaces
      # between the letters
      12
    end
  end
end
