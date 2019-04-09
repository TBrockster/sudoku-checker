# sudoku entry / conversion to 2d and printed (currently a sample sudoku)
one_d_sudoku = [
  0, 0, 0, 1, 0, 9, 0, 0, 0,
  0, 0, 6, 0, 4, 0, 8, 0, 0,
  0, 3, 0, 0, 0, 0, 0, 1, 0,
  3, 0, 0, 7, 0, 1, 0, 0, 6,
  5, 0, 0, 0, 8, 0, 0, 0, 7,
  0, 2, 0, 0, 0, 0, 0, 9, 0,
  0, 0, 3, 0, 0, 0, 2, 0, 0,
  0, 4, 8, 0, 3, 0, 6, 7, 0,
  0, 6, 0, 5, 0, 4, 0, 8, 0
]

two_d_sudoku = one_d_sudoku.each_slice(9).to_a

# basic retrival of user input
module Promptable
  def prompt(message = 'What would you like to do?', symbol = ':> ')
    puts message
    print symbol
    gets.chomp
  end
end

# tests the sum of the columns
def column_tester(array)
  column_test = []
  for x in 0..8 do
    column_test += array.transpose[x].find_all { |y| array.transpose[x].count(y) > 1 }
    if column_test.sum > 0
      return true
    else
      return false
    end
  end
end

# tests the sum of the rows
def row_tester(array)
  row_test = []
  for x in 0..8 do
    row_test += array.transpose[x].find_all { |y| array.transpose[x].count(y) > 1 }
    if row_test.sum > 0
      return true
    else
      return false
    end
  end
end

# tests each 3x3 section (top left, top middle, top right, etc)
def section_tester(array)
  # define rows
  row_one = array[0]
  row_two = array[1]
  row_three = array[2]
  row_four = array[3]
  row_five = array[4]
  row_six = array[5]
  row_seven = array[6]
  row_eight = array[7]
  row_nine = array[8]
  # define sections
  tl_section = [row_one[0..2], row_two[0..2], row_three[0..2]].flatten
  tm_section = [row_one[3..5], row_two[3..5], row_three[3..5]].flatten
  tr_section = [row_one[6..8], row_two[6..8], row_three[6..8]].flatten
  ml_section = [row_four[0..2], row_five[0..2], row_six [0..2]].flatten
  mm_section = [row_four[3..5], row_five[3..5], row_six[3..5]].flatten
  mr_section = [row_four[6..8], row_five[6..8], row_six[6..8]].flatten
  bl_section = [row_seven[0..2], row_eight[0..2], row_nine[0..2]].flatten
  bm_section = [row_seven[3..5], row_eight[3..5], row_nine[3..5]].flatten
  br_section = [row_seven[6..8], row_eight[6..8], row_nine[6..8]].flatten
  # check sections
  section_test = []
  section_test << tl_section.find_all { |y| tl_section.count(y) > 1 }
  section_test << tm_section.find_all { |y| tm_section.count(y) > 1 }
  section_test << tr_section.find_all { |y| tr_section.count(y) > 1 }
  section_test << ml_section.find_all { |y| ml_section.count(y) > 1 }
  section_test << mm_section.find_all { |y| mm_section.count(y) > 1 }
  section_test << mr_section.find_all { |y| mr_section.count(y) > 1 }
  section_test << bl_section.find_all { |y| bl_section.count(y) > 1 }
  section_test << bm_section.find_all { |y| bm_section.count(y) > 1 }
  section_test << br_section.find_all { |y| br_section.count(y) > 1 }
  section_test.flatten!
  if section_test.sum > 0
    return true
  else
    return false
  end
end

# program runner
if $PROGRAM_NAME == __FILE__
  include Promptable
  puts 'This is the initial Sudoku!'
  puts two_d_sudoku.map { |x| x.join(' ') }
  if column_tester(two_d_sudoku) || row_tester(two_d_sudoku) || section_tester(two_d_sudoku)
    puts 'but it is invalid :('
  else
    puts 'and it is valid :)'
  end
  column_to_replace = prompt('Which Column is the target square in? (1-9, left to right)').to_i - 1
  row_to_replace = prompt('Which Row is the target square in? (1-9, top to bottom)').to_i - 1
  replace_number = prompt('What number do you want to enter? (1-9)').to_i
  new_sudoku = two_d_sudoku
  new_sudoku[row_to_replace][column_to_replace] = replace_number
  puts new_sudoku.map { |x| x.join(' ') }
  if column_tester(new_sudoku) || row_tester(new_sudoku) || section_tester(new_sudoku)
    puts 'that was an invalid move :('
  else
    puts 'that was a valid move! :)'
  end
end
