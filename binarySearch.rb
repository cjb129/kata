require 'rubygems'
require 'set'
def search(numberToFind, array)
  index = array.length / 2
  for number in array
    if array[index] == numberToFind
      return true
    end
  end
  return false
end

require 'test/unit'
class SearchTest < Test::Unit::TestCase
  def test_empty_set_returns_nothing
    assert_equal false, search(nil, Array.new)
  end

  def test_single_element_set_that_that_includes_param
    assert_equal true, search(1, Array.new([1]))
  end

  def test_single_element_set_that_does_not_include_param
    assert_equal false, search(1, Array.new([2]))
  end

end
