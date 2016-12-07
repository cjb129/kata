require 'rubygems'
require 'set'
def search(numberToFind, set)
  return -1
end

require 'test/unit'
class SearchTest < Test::Unit::TestCase
  def test_empty_array_returns_nothing
    search(nil, SortedSet.new)
  end


end
