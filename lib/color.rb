# frozen_string_literal: true

# Adds color to strings printed to the terminal by extending the
# functionality of the built in String class.
# This is based almost entirely on this stackoverflow answer:
# https://stackoverflow.com/a/11482430
class String
  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end

  def bold_red
    colorize(31, 1)
  end

  def bold_green
    colorize(32, 1)
  end

  def bold_yellow
    colorize(33, 1)
  end

  def bold_blue
    colorize(34, 1)
  end

  def bold_pink
    colorize(35, 1)
  end

  def bold_light_blue
    colorize(36, 1)
  end

  def bold
    colorize(37, 1)
  end

  private

  def colorize(color_code, special = 0)
    "\e[#{special};#{color_code}m#{self}\e[0m"
  end
end
