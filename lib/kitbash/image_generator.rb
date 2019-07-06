module Kitbash
  class ImageGenerator
    require 'chunky_png'

    def initialize(width, height)
      @width = width
      @height = height
      @color_count = ChunkyPNG::Color::PREDEFINED_COLORS.count
    end

    def draw_circles(element_count, size_mod = 0.5)
      img = ChunkyPNG::Canvas.new(@width, @height, random_color)
      element_count.times do
        run_circle img, size_mod
      end
      img
    end

    def draw_random(element_count, size_mod = 0.5)
      img = ChunkyPNG::Canvas.new(@width, @height, random_color)
      element_count.times do
        ind = SecureRandom.random_number(3)
        if ind == 0
          run_circle img, size_mod
        elsif ind == 1
          run_rectangle img, size_mod
        elsif ind == 2
          run_square img, size_mod
        end
      end
      img
    end

    def draw_rectangles(element_count, size_mod = 0.5)
      img = ChunkyPNG::Canvas.new(@width, @height, random_color)
      element_count.times do
        run_rectangle img, size_mod
      end
      img
    end

    def draw_squares(element_count, size_mod = 0.5)
      img = ChunkyPNG::Canvas.new(@width, @height, random_color)
      element_count.times do
        run_square img, size_mod
      end
      img
    end

    private

    def random_color
      ind = SecureRandom.random_number(@color_count)
      ChunkyPNG::Color::PREDEFINED_COLORS.keys[ind]
    end

    def run_circle(img, size_mod)
      x = SecureRandom.random_number(@width)
      y = SecureRandom.random_number(@height)
      r = SecureRandom.random_number((@width * size_mod).to_i)
      color = random_color
      img.circle(x, y, r, color, color)
    end

    def run_rectangle(img, size_mod)
      x0 = SecureRandom.random_number(@width)
      y0 = SecureRandom.random_number(@height)
      w = SecureRandom.random_number((@width * size_mod).to_i)
      h = SecureRandom.random_number((@height * size_mod).to_i)
      x1 = x0 + w
      y1 = y0 + h
      color = random_color
      img.rect(x0, y0, x1, y1, color, color)
    end

    def run_square(img, size_mod)
      x0 = SecureRandom.random_number(@width)
      y0 = SecureRandom.random_number(@height)
      w = SecureRandom.random_number((@width * size_mod).to_i)
      x1 = x0 + w
      y1 = y0 + w
      color = random_color
      img.rect(x0, y0, x1, y1, color, color)
    end
  end
end
