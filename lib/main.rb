# frozen_string_literal: true

require_relative "./hangman"

puts "Welcome to hangman"
puts ""

secret_word = Hangman::SecretWord.new("hangman")
cipher = Hangman::Cipher.new(secret_word.word)
player = Hangman::Player.new

game = Hangman::Game.new(secret_word, cipher, player)

game.play
puts "You guessed the word!" if cipher.solved?
puts "Better luck next time. The secret word was #{secret_word.word}." unless cipher.solved?
