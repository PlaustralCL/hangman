# frozen_string_literal: true

require "yaml"
require_relative "../hangman"
require_relative "../file_operations"

module Hangman
  # Coordinates the activities outside of actual playing
  class Setup
    include FileOperations

    private

    attr_reader :secret_word, :cipher, :player

    public

    def initialize
      welcome
      choose_game_type
      game = Game.new(secret_word, cipher, player)
      game.play
      game_end
    end

    private

    def game_end
      puts "You guessed the word!" if solved?
      puts "Better luck next time. The secret word was #{secret_word.word}." unless solved?
    end

    def choose_game_type
      options = <<~HEREDOC
        Do you want to:
        (1) Load a saved game
        (2) Start a new game
      HEREDOC
      puts options
      game_type = input_number(max_value: 2)
      game_type == 1 ? saved_game : new_game
    end

    def new_game
      @secret_word = SecretWord.new
      @cipher = Cipher.new(secret_word.word)
      @player = Player.new
    end

    def saved_game
      entries = find_files("saved_games")
      list_files(entries)
      filename = "saved_games/#{choose_file(entries)}"
      load_file(filename)
    end

    def choose_file(entries)
      puts "Please enter the game (#) you would like to play"
      game_number = input_number(max_value: entries.length) - 1
      entries[game_number]
    end

    def input_number(max_value:, min_value: 1, selection: 0)
      loop do
        selection = gets.chomp.to_i
        break if Array(min_value..max_value).include?(selection)

        puts "Please limit your responses to numbers between '1' and '#{max_value}'".red
      end
      selection
    end

    def load_file(filename)
      game_state = load_yaml(filename)
      @secret_word = game_state[:secret_word]
      @cipher = game_state[:cipher]
      @player = game_state[:wrong_guesses]
    end

    def welcome
      intro = <<~HEREDOC
        Welcome to hangman
        A word that is 5 - 12 letters long will be selected.
        On each turn you can guess a letter. To win, you must solve the puzzle
        before you make 6 wrong guesses.
      HEREDOC

      puts intro
      puts ""
    end

    def solved?
      cipher.solved?
    end
  end
end
