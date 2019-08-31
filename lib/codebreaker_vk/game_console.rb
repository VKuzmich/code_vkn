# frozen_string_literal: true

module CodebreakerVk
  class GameConsole
    include Validation
    include Database
    include Output

    HINT = 'hint'
    SAVE = 'save'
    INPUT_DATA = /^[1-6]{4}$/.freeze

    def initialize(name, difficulty)
      @game = Game.new(name: name, difficulty: difficulty)
    end

    def start
      loop do
        break if @game.attempts.zero? || @game.win?

        start_info(@game.attempts, @game.hints)
        input = gets.chomp
        case input
        when GameMenu::EXIT then break close
        when HINT then next puts @game.use_hint
        when INPUT_DATA then puts @game.check(input)
        else puts I18n.t(:wrong_process)
        end
      end
      puts I18n.t(:game_over)
      statistics
    end

    def statistics
      summary_info(@game.secret)
      end_game
    end

    def end_game
      if @game.win?
        puts I18n.t(:win)
        puts I18n.t(:save)
        save_results if gets.chomp == SAVE
      else
        puts I18n.t(:lose)
      end
    end

    def close
      puts I18n.t(:goodbye)
      exit
    end
  end
end
