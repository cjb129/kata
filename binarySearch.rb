require 'rubygems'
require 'set'
def search(numberToFind, set)
  for number in set
    if number == numberToFind
      return true
    end
  end
  return -1
end

require 'test/unit'
class SearchTest < Test::Unit::TestCase
  def test_empty_set_returns_nothing
    assert_equal -1, search(nil, SortedSet.new)
  end

  def test_search_single_element_that_exists
    assert_equal true, search(1, SortedSet.new([1]))
  end

end
