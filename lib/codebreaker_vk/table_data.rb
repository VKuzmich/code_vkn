# frozen_string_literal: true

module CodebreakerVk
  class TableData
    attr_accessor :name, :difficulty, :attempts_total, :attempts_used, :hints_total, :hints_used

    def initialize(name:, difficulty:, attempts_total:, attempts_used:, hints_total:, hints_used:)
      @name = name
      @difficulty = difficulty
      @attempts_total = attempts_total
      @attempts_used = attempts_used
      @hints_total = hints_total
      @hints_used = hints_used
    end

    def to_s
      I18n.t(:stats,
             name: @name,
             difficulty: @difficulty,
             attempts_total: @attempts_total,
             attempts_used: @attempts_used,
             hints_total: @hints_total,
             hints_used: @hints_used)
    end
  end
end
