require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  let(:input) { 25 }
  let(:bad) { 'qwerty' }
  let(:empty) { '' }

  scenario 'input correct data' do
    visit root_path
    fill_in :input_value, with: input
    find('.btn').click
    expect(find('#show_container')).to have_text("Найденное количество факториалов: 4. Гипотеза Симона подтверждена.\n\nФакториал Значение факториала Тройка чисел\n3! 6 1, 2, 3\n4! 24 2, 3, 4\n5! 120 4, 5, 6\n6! 720 8, 9, 10")
  end

  scenario 'input incorrect data' do
    visit root_path
    fill_in :input_value, with: bad
    find('.btn').click
    expect(find('#show_container')).to have_text("Введён символ, отличный от цифры")
  end

  scenario 'input empty string' do
    visit root_path
    fill_in :input_value, with: empty
    find('.btn').click
    expect(find('#show_container')).to have_text("Введена пустая строка")
  end
end