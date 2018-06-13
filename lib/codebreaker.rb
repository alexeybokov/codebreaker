require 'codebreaker/version'

module Codebreaker
  class Game

    def initialize
      @secret_code = []
      @user_code = []
      @max_attempts = 8
    end

    def start
      4.times do
        @secret_code.push(rand(1...6))
      end
    end

    def run_game
      @max_attempts.times do |current_round|
        puts "Round: #{current_round + 1}\n"
        user_input
        return won if won?
        check_result
        puts "#{@max_attempts - current_round - 1} attempts left\n"
      end
      puts "You're looser!"
    end

    def won?
      @user_code == @secret_code
    end

    def won
      puts 'You won!'
    end

    NUMBERS_TO_WORDS = {
        0 => 'first',
        1 => 'second',
        2 => 'third',
        3 => 'fourth'
    }.freeze

    def number_valid?(number)
      number >= 1 && number <= 6
    end

    def user_input
      @user_code = []
      4.times do |index|
        puts "Enter #{NUMBERS_TO_WORDS[index]} number from 1 to 6:"
        number = 0
        while !number_valid?(number) do
          number = gets.chomp.to_i
          puts 'Use only numbers from 1 to 6!' unless number_valid?(number)
        end
        @user_code.push(number)
      end
      puts "Your codes: #{@user_code.join(' ')}"
    end

    def check_result
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
  end
end
