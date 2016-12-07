require 'rubygems'
require 'set'
def search(numberToFind, array)
  index = array.length / 2

  if array[index] == numberToFind
    return index
  end

  return -1
end

require 'test/unit'
class SearchTest < Test::Unit::TestCase
  def test_empty_array_returns_nothing
    assert_equal -1, search(1, Array.new)
  end

  def test_single_element_array_that_that_includes_param
    assert_equal 0, search(1, Array.new([1]))
  end

  def test_single_element_array_that_does_not_include_param
    assert_equal -1, search(1, Array.new([2]))
  end

  def test_two_element_array_that_includes_param_in_first_half
    assert_equal 0, search(1, Array.new([1,2]))
  end

end
