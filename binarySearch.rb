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
