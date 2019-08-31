# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe Database do
    let(:game_class) { Class.new { extend Database } }
    let(:path) { './spec/fixtures/seed.yaml' }
    let(:random_file) { 'random_file_name.yaml' }
    let(:summary) do
      {
          name: 'Rspec',
          difficulty: Game::DIFFICULTY_LEVEL.keys[0],
          attempts_total: 15,
          attempts_used: 1,
          hints_total: 3,
          hints_used: 1
      }
    end

    describe '#save' do
      context 'when file does not exist' do
        it 'saves a TableData object to a new file' do
          game_class.save(summary, random_file)
          expect(File.exist?(random_file)).to eq(true)
          File.delete(random_file)
        end
      end

      # context 'when file exists' do
      #   it 'saves a TableData object to exists file' do
      #     expect { game_class.save(summary, path) }.to change { File.new(path).size }
      #   end
      # end
    end

    # describe '#load' do
    #   it 'loads a TableData object array from file' do
    #     game_class.save(summary, path)
    #     expect(game_class.load(path)[0].is_a?(TableData)).to eq(true)
    #   end
    # end
  end
end
