# frozen_string_literal: true

require "yaml"
require_relative "./hangman"

puts "Welcome to hangman"
puts ""

def new_game
  secret_word = Hangman::SecretWord.new("hangman")
  cipher = Hangman::Cipher.new(secret_word.word)
  player = Hangman::Player.new
  [secret_word, cipher, player]
end

def load_game
  filename = "saved_games/test_save.yaml"
  game_state = YAML::load(File.read(filename))
  secret_word = Hangman::SecretWord.new(game_state[:secret_word])
  cipher = Hangman::Cipher.new(game_state[:secret_word], game_state[:cipher])
  player = Hangman::Player.new(game_state[:wrong_guesses])
  [secret_word, cipher, player]
end

secret_word = ""
cipher = ""
player = ""

puts "Do you want to (1) Load a saved game or (2) Start a new game?"
game_type = gets.chomp.to_i
if game_type == 1
  secret_word, cipher, player = load_game
else
  secret_word, cipher, player = new_game
end

puts ""
game = Hangman::Game.new(secret_word, cipher, player)

game.play




puts "You guessed the word!" if cipher.solved?
puts "Better luck next time. The secret word was #{secret_word.word}." unless cipher.solved?
