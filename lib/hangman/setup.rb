# frozen_string_literal: true

require "yaml"
require_relative "../hangman"

module Hangman
  # Setup for a new game
  class Setup
    attr_reader :secret_word, :cipher, :player

    def new_game
      @secret_word = SecretWord.new("hangman")
      @cipher = Cipher.new(secret_word.word)
      @player = Player.new
      [secret_word, cipher, player]
    end

    def load_game
      entries = find_files
      show_files(entries)
      filename = "saved_games/#{choose_file(entries)}"
      # filename = "saved_games/#{filename}"
      read_file(filename)
      [secret_word, cipher, player]
    end

    def choose_file(entries)
      puts "Please enter the game (#) you would like to play"
      game_number = gets.chomp.to_i
      entries[game_number]
    end

    def read_file(filename)
      game_state = YAML.load(File.read(filename))
      @secret_word = SecretWord.new(game_state[:secret_word])
      @cipher = Cipher.new(game_state[:secret_word], game_state[:cipher])
      @player = Player.new(game_state[:wrong_guesses])
    end

    def find_files
      Dir.entries("saved_games").sort[2..-1]
    end

    def show_files(entries)
      puts "\n(#)  File name\n\n"
      entries.each_with_index do |file, index|
        puts "(#{index})   #{file}\n\n"
      end
    end


  end
end
