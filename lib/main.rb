# frozen_string_literal: true

require "yaml"
require_relative "./hangman"

puts "Welcome to hangman"
puts ""

secret_word = ""
cipher = ""
player = ""
game = Hangman::Setup.new

puts "Do you want to (1) Load a saved game or (2) Start a new game?"
game_type = gets.chomp.to_i
if game_type == 1
  secret_word, cipher, player = game.load_game
else
  secret_word, cipher, player = game.new_game
end

puts ""
game = Hangman::Game.new(secret_word, cipher, player)

game.play




puts "You guessed the word!" if cipher.solved?
puts "Better luck next time. The secret word was #{secret_word.word}." unless cipher.solved?
