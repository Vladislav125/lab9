# frozen_string_literal: true

# class ExampleController
class ExampleController < ApplicationController
  def input; end

  def show
    @input = params[:input_value]

    return if check

    @input = @input.to_i
    set_values
    count
    create_message
  end

  private

  def create_message
    @message = "Найденное количество факториалов: #{@results.length}."
    @message += ' Недостаточное количество для подтверждения гипотезы Симона.' if @results.length < 4
    @message += ' Гипотеза Симона подтверждена.' if @results.length == 4
  end

  def set_values
    @input = 1 if @input == 0 
    @number = 1
    @factorial = 1
    @num1 = 1
    @num2 = 2
    @num3 = 3
    @results = []
    Struct.new('Results', :factorial_number, :three_numbers, :factorial_value)
  end

  def product
    @num1 * @num2 * @num3
  end

  def define_first_three_numbers
    @num1 = (@factorial**(1.0 / 3.0)).truncate
    @num2 = @num1 + 1
    @num3 = @num1 + 2
  end

  def values_not_equal
    product < @factorial ? less_than_need : bigger_than_need
    add_result if product == @factorial
  end

  def less_than_need
    loop do
      @num1 += 1
      @num2 += 1
      @num3 += 1
      break if product >= @factorial
    end
  end

  def bigger_than_need
    loop do
      @num1 -= 1
      @num2 -= 1
      @num3 -= 1
      break if product <= @factorial
    end
  end

  def add_result
    @results << Struct::Results.new("#{@number}!", [@num1, @num2, @num3].join(', '), product.to_s)
  end

  def count
    loop do
      define_first_three_numbers
      product == @factorial ? add_result : values_not_equal
      @number += 1
      @factorial *= @number
      break if @number - 1 == @input
    end
    @results
  end

  def check
    @error = false
    @error = true if check_nil || check_other_errors
    @error
  end

  def check_nil
    if @input.nil?
      @error_message = 'Не переданы параметры'
      return true
    end
    false
  end

  def check_other_errors
    unless @input.match?(/^(\d|[1-9]\d+)$/)
      @error_message = if @input.empty?
                         'Введена пустая строка'
                       else
                         'Введён символ, отличный от цифры'
                       end
      return true
    end
    false
  end
end
