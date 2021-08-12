# frozen_string_literal: true

require_relative "./hangman"

at_exit do
  puts "Thanks for playing"
end

Hangman::Setup.new
