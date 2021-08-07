# frozen_string_literal: true

require "test_helper"
require_relative "../lib/hangman/secret_word"

# Tests for class SecretWord
class SecretWordTest < Minitest::Test
  def random_word
    Hangman::SecretWord.new.new_word
  end

  def test_pre_defined_word
    word = Hangman::SecretWord.new("hangman").new_word
    assert_equal("hangman", word)
  end

  def test_random_word_min_length
    word = random_word
    assert(word.length >= 5, "The word is too short")
  end

  def test_random_word_max_length
    word = random_word
    assert(word.length <= 12, "The word is too long")
  end

  def test_word_maintains_new_word
    word_source = Hangman::SecretWord.new
    secret_word = word_source.new_word
    word_check = word_source.word
    assert_equal(secret_word, word_check)
  end
end
