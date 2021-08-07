# frozen_string_literal: true

require "test_helper"
require_relative "../lib/hangman/cipher.rb"

# Tests for class Cipher
class CipherTest < Minitest::Test
  attr_reader :word, :cipher

  def setup
    @word = define_word
    @cipher = Hangman::Cipher.new(word)
  end

  def define_word
    Hangman::SecretWord.new("hangman").new_word
  end

  def test_blank_cipher_has_all_blanks
    word = define_word
    assert_equal("_ _ _ _ _ _ _ ", cipher.show_cipher)
  end

  def test_cipher_works_for_correct_letter
    cipher.update_cipher("a")
    assert_equal("_ a _ _ _ a _ ", cipher.show_cipher)
  end

  def test_works_multiple_letters
    cipher.update_cipher("a")
    cipher.update_cipher("h")
    assert_equal("h a _ _ _ a _ ", cipher.show_cipher)
  end

  def test_find_indicies
    skip
    assert_equal([1, 5], cipher.find_indicies("a"))
  end


end
