require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    context '#initialize' do
      let(:game) { Game.new }
      before do
        game.start
      end

      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq 4
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code).to_s).to match(/[1-6]+/)
      end

      it 'max attempt set to 8' do
        expect(game.instance_variable_get(:@max_attempts)).to eq 8
      end
    end

    context '#check_result' do
      let(:game) { Game.new }
      before do
        game.start
        game.instance_variable_set :@secret_code, [6, 1, 3, 4]
      end

      it 'should return +' do
        game.instance_variable_set :@user_code, [6, 2, 5, 2]
        expect(game.check_result).to eq(["+"])
      end

      it 'should return ++' do
        game.instance_variable_set :@user_code, [6, 1, 5, 2]
        expect(game.check_result).to eq(["+", "+"])
      end

      it 'should return +++' do
        game.instance_variable_set :@user_code, [6, 1, 5, 4]
        expect(game.check_result).to eq(["+", "+", "+"])
      end

      it 'should return -' do
        game.instance_variable_set :@user_code, [4, 2, 5, 2]
        expect(game.check_result).to eq(["-"])
      end

      it 'should return --' do
        game.instance_variable_set :@user_code, [1, 3, 5, 2]
        expect(game.check_result).to eq(["-", "-"])
      end

      it 'should return ---' do
        game.instance_variable_set :@user_code, [4, 3, 6, 2]
        expect(game.check_result).to eq(["-", "-", "-"])
      end

      it 'should return --++' do
        game.instance_variable_set :@user_code, [1, 6, 3, 4]
        expect(game.check_result).to eq(["-", "-", "+", "+"])
      end
    end
  end
end
