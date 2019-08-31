# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe GameMenu do
    describe '.welcome' do

      after do
        described_class.welcome
      end

      it 'shows greeting' do
        allow(described_class).to receive(:run)
        expect(STDOUT).to receive(:puts).with(I18n.t(:greeting))
      end

      it 'calls run method' do
        expect(described_class).to receive(:run)
      end
    end

    describe '.run' do
      before do
        allow(described_class).to receive(:loop).and_yield
        allow(described_class).to receive(:gets).and_return(GameMenu::START)
        allow(described_class).to receive(:gets).and_return(GameMenu::RULES)
        allow(described_class).to receive(:gets).and_return(GameMenu::STATISTICS)
        allow(described_class).to receive(:gets).and_return(GameMenu::EXIT)
      end

      after do
        described_class.run
      end

      it 'calls registration method' do
        expect(described_class).to receive(:registration)
      end

      it 'calls rules method' do
        expect(described_class).to receive(:rules)
      end

      it 'calls stats method' do
        expect(described_class).to receive(:stats)
      end

      it 'calls close method' do
        expect(described_class).to receive(:close)
      end

      it 'shows a message' do
        allow(STDOUT).to receive(:puts).with(anything)
        allow(described_class).to receive(:gets).and_return('wrong input')
        expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_run))
      end
    end

    describe '.rules' do
      it 'shows the rules' do
        expect { described_class.rules }.to output(I18n.t(:rules)).to_stdout
      end
    end

    describe '.stats' do
      it 'shows a stats' do
        expect(described_class).to receive(:puts).with(I18n.t(:no_stats))
        described_class.stats
      end
    end

    describe '.close' do
      it 'closes' do
        expect(described_class).to receive(:exit)
        described_class.close
      end
    end

    describe '.registration' do
      it 'returns GameConsole start' do
        allow(described_class).to receive(:loop).and_yield
        allow(described_class).to receive(:gets).and_return("Name\n", "Easy\n")
        expect(GameConsole).to receive_message_chain(:new, :start)
        described_class.registration
      end
    end

    describe '.choose_difficulty' do
      before do
        allow(described_class).to receive(:loop).and_yield
      end

      it 'calls close method' do
        allow(described_class).to receive(:gets).and_return(GameMenu::EXIT)
        expect(described_class).to receive(:close)
        described_class.choose_difficulty
      end

      it 'shows a message' do
        allow(STDOUT).to receive(:puts).with(anything)
        allow(described_class).to receive(:gets).and_return(I18n.t(:wrong_input))
        expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_difficulty))
        described_class.choose_difficulty
      end

      it 'returns a correct difficulty level' do
        Game::DIFFICULTY_LEVEL.each_key do |key|
          allow(described_class).to receive(:gets).and_return(key.to_s)
          expect(described_class.choose_difficulty).to eq(key)
        end
      end
    end

    describe '.choose_name' do
      before do
        allow(described_class).to receive(:loop).and_yield
      end

      it 'shows a message' do
        allow(STDOUT).to receive(:puts).with(anything)
        allow(described_class).to receive(:gets).and_return("no\n")
        expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_name))
        described_class.choose_name
      end

      it 'returns a choosen name' do
        allow(described_class).to receive(:gets).and_return("Name\n")
        expect(described_class.choose_name).to eq('Name')
      end
    end
  end
end
