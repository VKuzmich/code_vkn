# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe Game do
    subject(:game) { described_class.new(name: 'Rspec', difficulty: :easy) }

    let(:examples) { YAML.load_file('spec/fixtures/examples.yml') }
    let(:guess_plus) { Game::GOT_IT }
    let(:guess_minus) { Game::NOT_YET }

    describe '#use_hint' do
      it 'decrements hints and calls a #hint' do
        game.instance_variable_set(:@hints, 1)
        expect { game.use_hint }.to change(game, :hints).by(-1)
      end

      it 'returns a message if no hints left' do
        game.instance_variable_set(:@hints, 0)
        expect(game.use_hint).to eq(I18n.t(:no_hints))
      end
    end

    describe '#check' do
      it 'returns true when #check_numbers equal secret' do
        expect(game.check(game.secret)).to eq(Game::GOT_IT * 4)
      end
    end

    describe 'the correct answer to guessing numbers' do
      examples.each do |example|
        it "checks that the result is #{example[2]} when code is #{example[0]}, numbers are #{example[1]}" do
          game.instance_variable_set(:@secret, example[0])
          numbers = example[1]
          expect(game.check(numbers)).to eq(example[2])
        end
      end
    end
  end
end
