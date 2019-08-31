# frozen_string_literal: true

module CodebreakerVk
  class Game
    include Output
    SECRET_CODE_LENGTH = 4
    RANGE_START = 1
    RANGE_END = 6
    NOT_YET = '-'
    GOT_IT = '+'
    DIFFICULTY_LEVEL = {
        easy: { attempts: 15, hints: 3 },
        medium: { attempts: 10, hints: 2 },
        hell: { attempts: 5, hints: 1 }
    }.freeze

    attr_accessor :attempts_total, :attempts, :difficulty, :hints_total, :hints, :name, :secret

    def initialize(name:, difficulty:)
      @name = name
      @difficulty = difficulty
      @attempts = DIFFICULTY_LEVEL[difficulty][:attempts]
      @hints = DIFFICULTY_LEVEL[difficulty][:hints]
      @secret = make_number
      @unused_hints = @secret.chars
    end

    def make_number(numbers = RANGE_END)
      (1..SECRET_CODE_LENGTH).map { rand(RANGE_START..numbers) }.join
    end

    def check(number)
      @attempts -= 1
      @last_result = check_numbers(@secret.chars, number.chars)
    end

    def win?
      @last_result == GOT_IT * SECRET_CODE_LENGTH
    end

    def use_hint
      return I18n.t(:no_hints) unless @hints.positive?

      @hints -= 1
      hint(@unused_hints)
    end

    private

    def check_numbers(secret, numbers)
      exact_matches, non_exact_matches = secret.zip(numbers).partition do |secret_number, input_number|
        secret_number == input_number
      end

      result = Array.new(exact_matches.count, GOT_IT)

      find_non_exact_matches(result, non_exact_matches) if non_exact_matches.any?

      result.join
    end

    def find_non_exact_matches(result, non_exact_matches)
      secret, numbers = non_exact_matches.transpose
      numbers.each do |number_element|
        next unless secret.include? number_element

        result.push(NOT_YET) && secret.delete_at(secret.index(number_element))
      end
    end

    def hint(secret)
      secret.shuffle.pop
    end
  end
end
