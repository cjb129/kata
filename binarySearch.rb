require 'rubygems'
def search(numberToFind, sortedArray)
  return -1
end

require 'test/unit'
class SearchTest < Test::Unit::TestCase
  def test_empty_array_returns_nothing
    search(nil, Array.new)
  end
end
