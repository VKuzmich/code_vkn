# frozen_string_literal: true

module CodebreakerVk
  module Database
    SEED = 'database.yaml'

    def load(path = SEED)
      YAML.load_file(path)
    end

    def save(summary, path = SEED)
      row = TableData.new(summary)
      if File.exist?(path)
        table = load(path)
        table << row
        File.write(path, table.to_yaml)
      else
        File.write(path, [row].to_yaml)
      end
    end

    def save_results
      attempts_total = Game::DIFFICULTY_LEVEL[@game.difficulty][:attempts]
      hints_total = Game::DIFFICULTY_LEVEL[@game.difficulty][:hints]
      summary = {
        name: @game.name,
        difficulty: @game.difficulty,
        attempts_total: attempts_total,
        attempts_used: attempts_total - @game.attempts,
        hints_total: hints_total,
        hints_used: hints_total - @game.hints
      }
      save(summary)
    end
  end
end
