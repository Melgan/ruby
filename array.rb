#Creating array

names = Array.new
#=> []
#or with size
names = Array.new(5)
#=> [nil, nil, nil, nil, nil]
puts names.size  # This returns 5
puts names.length # This also returns 5

#You can assign a value to each element in the array as follows
names = Array.new(4, "sth")
#=> [sth, sth, sth] 

#You can also use a block with new, populating each element with what the block evaluates to:
nums = Array.new(10) do |i| 
  i = i + 2 
end
#=>[2, 3, 4, 5, 6, 7, 8, 9, 10]

#creating arrays using another method
nums = Array.[](1, 2, 3, 4, 5)
#=> [1, 2, 3, 4, 5]

#or
nums = Array[1, 2, 3, 4,5]
#=> [1, 2, 3, 4, 5]

#or with using ranges
nums = Array(0..9)
#=>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

#Create array with hashes
Array.new(4) { Hash.new } 
#=> [{}, {}, {}, {}]

#or 
Array({:jeden => 1, :dwa => 2}) 
#=> [[:jeden, 1], [:dwa, 2]]

#diversial array
empty_table = Array.new(3) { Array.new(3) }
#=> [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]

#sometimes is more comfortable to create a hash which is using like a 2d array
class SparseArray
  attr_reader :hash

  def initialize
    @hash = {}
  end

  def [](key)
    hash[key] ||= {}
  end

  def rows
    hash.length   
  end

  alias_method :length, :rows
end

#using created array
parse_array = SparseArray.new
sparse_array[1][2] = 3
sparse_array[1][2] #=> 3
p sparse_array.hash
#=> {1=>{2=>3}}
sparse_array.length    #=> 1
sparse_array.rows      #=> 1
sparse_array[0].length #=> 0
sparse_array[1].length #=> 1

#Accessing elements
arr = [1, 2, 3, 4, 5, 6]
arr[2]    #=> 3
arr[100]  #=> nil
arr[-3]   #=> 4
arr[2, 3] #=> [3, 4, 5]
arr[1..4] #=> [2, 3, 4, 5]
arr.at(0) #=> 1

#Accessing first, last, n'th element
arr = [1, 2, 3, 4, 5, 6]
arr.first #=> 1
arr.last  #=> 6
arr.take(3) #=> [1, 2, 3]

#Accessing the elements after specified n elements 
arr = [1, 2, 3, 4, 5, 6]
arr.drop(3) #=> [4, 5, 6]

#numbers of elements
arr = [1, 2, 3, 4, 5, 6]
arr.length #=> 5
arr.count #=> 5

#to check if array contains any element
arr = [1, 2, 3, 4, 5, 6]
arr.empty? #=> false

#to check if include specified element
arr = [1, 2, 3, 4, 5, 6]
arr.include?(7) #=> false

#Adding items to array
arr = [1, 2, 3, 4]
arr.push(5) #=> [1, 2, 3, 4, 5]
arr << 6    #=> [1, 2, 3, 4, 5, 6]

#add a new item to the beginning of an array.
arr.unshift(0) #=> [0, 1, 2, 3, 4, 5, 6]

#add a new element to an array at any position.
arr.insert(3, 'apple')  #=> [0, 1, 2, 'apple', 3, 4, 5, 6]

#merge two arrays 
merged_array = []
arr1.each do |i|
  merged_array << [a[0], a[1]
end

#Removing Items from an Array

#remove the last element in an array and returns it:
arr =  [1, 2, 3, 4, 5, 6]
arr.pop #=> 6
arr #=> [1, 2, 3, 4, 5]

#retrieve and at the same time remove the first item
arr.shift #=> 1
arr #=> [2, 3, 4, 5]

#delete an element at a particular index
arr.delete_at(2) #=> 4
arr #=> [2, 3, 5]
#or
arr = [1, 2, 2, 3]
arr.delete(2) #=> [1, 3]

#remove nil values from an array
arr = ['foo', 0, nil, 'bar', 7, 'baz', nil]
arr.compact  #=> ['foo', 0, 'bar', 7, 'baz']
arr          #=> ['foo', 0, nil, 'bar', 7, 'baz', nil]
arr.compact! #=> ['foo', 0, 'bar', 7, 'baz']
arr          #=> ['foo', 0, 'bar', 7, 'baz']

#remove duplicate elements from an array.
arr = [2, 5, 6, 556, 6, 6, 8, 9, 0, 123, 556]
arr.uniq #=> [2, 5, 6, 556, 8, 9, 0, 123]

#Iterating over Arrays
#Note that method each leaves the array unchanged.

arr = [1, 2, 3, 4, 5]
arr.each do |a| 
  print a -= 10, " " 
end
# prints: -9 -8 -7 -6 -5
#=> [1, 2, 3, 4, 5]

#another example
words = %w[rats live on no evil star]
str = ""
words.reverse_each { |word| str += "#{word.reverse} " }
str #=> "rats live on no evil star "

#create a new array based on the original array, but with the values modified by the supplied block
arr.map { |a| 2*a }   #=> [2, 4, 6, 8, 10]
arr                   #=> [1, 2, 3, 4, 5]
arr.map! { |a| a**2 } #=> [1, 4, 9, 16, 25]
arr                   #=> [1, 4, 9, 16, 25]

#Selecting Items from an Array

#Elements can be selected from an array according to criteria defined in a block. 

#Non-destructive selection
arr = [1, 2, 3, 4, 5, 6]
arr.select { |a| a > 3 }     #=> [4, 5, 6]
arr.reject { |a| a < 3 }     #=> [3, 4, 5, 6]
arr.drop_while { |a| a < 4 } #=> [4, 5, 6]
arr                          #=> [1, 2, 3, 4, 5, 6]

#Destructive selection
arr.delete_if { |a| a < 4 } #=> [4, 5, 6]
arr                         #=> [4, 5, 6]

arr = [1, 2, 3, 4, 5, 6]
arr.keep_if { |a| a < 4 } #=> [1, 2, 3]
arr                       #=> [1, 2, 3]
