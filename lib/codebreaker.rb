require 'codebreaker/version'

module Codebreaker
  class Game
    DEFAULT_ATTEMPTS_COUNT = 8
    SECRET_CODE_RANGE = 1..6
    NUMBERS_TO_WORDS = {
      0 => 'first',
      1 => 'second',
      2 => 'third',
      3 => 'fourth'
    }.freeze

    def initialize
      @hint = true
      restart_game
    end

    def restart_game
      @secret_code = []
      @user_code = []
      4.times do
        @secret_code.push(rand(SECRET_CODE_RANGE))
      end
    end

    def run
      DEFAULT_ATTEMPTS_COUNT.times do |current_round|
        puts "Round: #{current_round + 1}\n"
        validate_user_input
        return won if won?
        prepare_result
        puts "#{DEFAULT_ATTEMPTS_COUNT - current_round - 1} attempts left\n"
      end
      lost
    end

    def validate_user_input
      @user_code = []
      4.times do |index|
        puts "Enter #{NUMBERS_TO_WORDS[index]} number from 1 to 6:"
        number = 0
        while !number_valid?(number) do
          number = $stdin.gets.chomp.to_i
          puts 'Use only numbers from 1 to 6!' unless number_valid?(number)
        end
        @user_code.push(number)
      end
    end

    def prepare_result
      result = []
      common = @secret_code & @user_code
      @user_code.each_with_index.map do |code, index|
        if code == @secret_code[index]
          result.push '+'
        elsif common.include?(code)
          result.push '-'
        end
      end
      puts "Round result: #{result.join(' ')}"
      result
    end

    def get_hint
      @hint = false
      result = %w(* * * *)
      index = rand(4)
      result[index] = @secret_code[index]
      p result
      result.join
    end

    private

    def number_valid?(number)
      number >= 1 && number <= 6
    end

    def won?
      @user_code == @secret_code
    end

    def won
      puts 'You won!'
      true
    end

    def lost
      puts "You're looser!"
      false
    end
  end
end
