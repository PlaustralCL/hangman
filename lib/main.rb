# frozen_string_literal: true

require "yaml"
require_relative "./hangman"

puts "Welcome to hangman"
puts "A word that is 5 - 12 letters long will be selected."
puts "On each turn you can guess a letter. To win, you must solve the puzzle before you make 6 wrong guesses."
puts ""

secret_word = ""
cipher = ""
player = ""
game = Hangman::Setup.new

puts "Do you want to:"
puts "(1) Load a saved game"
puts "(2) Start a new game\n\n"
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
