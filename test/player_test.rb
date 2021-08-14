# frozen_string_literal: true

# require "test_helper"
require "stringio"
require_relative "../lib/hangman"

# Tests for class Player
class PlayerTest < Minitest::Test
  attr_reader :player

  def setup
    @player = Hangman::Player.new
  end

  def teardown
    $stdin = STDIN
    $stdout = STDOUT
  end

  def test_new_guess
    string_io = StringIO.new("a")
    string_output = StringIO.new
    $stdout = string_output
    $stdin = string_io
    player.new_guess
    assert_equal("a", player.guess)
  end

  def test_update_wrong_guesses
    string_io = StringIO.new("z")
    string_output = StringIO.new
    $stdout = string_output
    $stdin = string_io
    player.new_guess
    assert_equal("z ", player.update_wrong_guesses.join)
  end

  def test_new_guess_rejects_bad_input
    string_input = StringIO.new
    string_input.puts("1")
    string_input.puts("a")
    string_input.rewind
    string_output = StringIO.new
    $stdout = string_output
    $stdin = string_input
    player.new_guess
    assert_equal("a", player.guess)
  end

end
