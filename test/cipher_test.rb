# frozen_string_literal: true

require "test_helper"
require_relative "../lib/hangman/cipher.rb"

# Tests for class Cipher
class CipherTest < Minitest::Test
  def setup

  end
  def define_word
    Hangman::SecretWord.new("hangman").new_word
  end

  def test_blank_cipher_has_all_blanks
    word = define_word
    cipher = Hangman::Cipher.new(word).blank_cipher
    assert_equal("_ _ _ _ _ _ _ ", cipher)
  end

  def test_cipher_works_for_correct_letter
    word = define_word
    cipher = Hangman::Cipher.new(word)
    cipher.blank_cipher
    assert_equal("_ a _ _ _ a _ ", cipher.update_cipher("a"))
  end

  def test_find_indicies
    word = define_word
    cipher = Hangman::Cipher.new(word)
    cipher.blank_cipher
    assert_equal([1, 5], cipher.find_indicies("a"))
  end
end
