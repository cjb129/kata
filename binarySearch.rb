require 'rubygems'
require 'set'

def search(numberToFind, array)
  index = (array.length - 1) / 2

  if array[index] == numberToFind
    return true
  end
  if index < 0
    return false
  end

  if array[index] < numberToFind
    search(numberToFind, array.drop(index+1))
  else
    search(numberToFind, array.take(index))
  end
end

require 'test/unit'
class SearchTest < Test::Unit::TestCase
  def test_empty_array_returns_nothing
    assert_equal false, search(1, Array.new)
  end

  def test_single_element_array_that_that_includes_param
    assert_equal true, search(1, Array.new([1]))
  end

  def test_single_element_array_that_does_not_include_param
    assert_equal false, search(1, Array.new([2]))
  end

  def test_two_element_array_that_includes_param_in_first_half
    assert_equal true, search(1, Array.new([1,2]))
  end

  def test_two_element_array_that_includes_param_in_second_half
    assert_equal true, search(2, Array.new([1,2]))
  end

  def test_two_element_array_that_does_not_include_param
    assert_equal false, search(0, Array.new([1,2]))
  end

  def test_three_element_array_where_param_is_middle_element
    assert_equal true, search(1, Array.new([0,1,2]))
  end

  def test_three_element_array_with_param_in_first_half
    assert_equal true, search(0, Array.new([0,1,2]))
  end

  def test_three_element_array_with_param_in_second_half
    assert_equal true, search(2, Array.new([0,1,2]))
  end

  def test_three_element_array_that_does_not_include_param
    assert_equal false, search(5, Array.new([0,1,2]))
  end

  def test_four_element_array_v1
    assert_equal true, search(0, Array.new([0,1,2,3]))
  end

  def test_four_element_array_v2
    assert_equal true, search(1, Array.new([0,1,2,3]))
  end

  def test_four_element_array_v3
    assert_equal true, search(2, Array.new([0,1,2,3]))
  end

  def test_four_element_array_v4
    assert_equal true, search(3, Array.new([0,1,2,3]))
  end

  def test_four_element_array_that_does_not_include_param
    assert_equal false, search(4, Array.new([0,1,2,3]))
  end
end
