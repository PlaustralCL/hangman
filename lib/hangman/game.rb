# frozen_string_literal: true

require "yaml"
require_relative "./game_file"

module Hangman
  # Coordinates the in-game action
  class Game
    attr_reader :secret_word, :cipher, :player

    def initialize(secret_word, cipher, player)
      @secret_word = secret_word
      @cipher = cipher
      @player = player
    end

    def play
      show_cipher
      show_wrong_guess
      while current_wrong_guesses < allowed_wrong_guesses
        play_one_round
        break if cipher.solved?

        show_wrong_guess
      end
    end

    private

    def show_cipher
      puts cipher.show_cipher
    end

    def show_wrong_guess
      puts "Wrong guesses: #{player.wrong_guesses_string}\n\n"
    end

    def play_one_round
      player.new_guess
      evaluate_guess
      show_cipher
    end

    def evaluate_guess
      if keywords.include?(guess)
        evaluate_keywords
      elsif already_guessed?
        puts "You have already guessed that letter. Please try again".red
      elsif word.include?(guess)
        cipher.update_cipher(guess)
      else
        player.update_wrong_guesses
      end
    end

    def already_guessed?
      cipher.cipher.include?(guess) || player.wrong_guesses.include?(guess)
    end

    def evaluate_keywords
      guess == "save" ? save_game : exit
    end

    def save_game
      game_state = { secret_word: secret_word, cipher: cipher, wrong_guesses: player }
      game_file = GameFile.new(game_state)
      game_file.write
      puts "The game is saved as #{game_file.filename}"
      exit
    end

    def guess
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
      # between the letters. For example, 6 guesses needs a value of 12 here
      12
    end

    def current_wrong_guesses
      player.wrong_guesses.length
    end
  end
end
