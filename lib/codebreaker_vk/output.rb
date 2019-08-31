# frozen_string_literal: true

module CodebreakerVk
  module Output
    def start_info(attempts, hints)
      puts I18n.t(:game_process, attempts: attempts, hints: hints)
    end

    def summary_info(secret)
      puts I18n.t(:secret, secret: secret)
    end

    def rules
      puts I18n.t(:rules)
    end
  end
end
