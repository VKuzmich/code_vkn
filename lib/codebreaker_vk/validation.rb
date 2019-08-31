# frozen_string_literal: true

module CodebreakerVk
  module Validation
    MIN_LETTERS = 3
    MAX_LETTERS = 20

    def valid_string_length?(name, min = MIN_LETTERS, max = MAX_LETTERS)
      name.is_a?(String) && name.length.between?(min, max)
    end
  end
end
