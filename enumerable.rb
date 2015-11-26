
### Enumerable
 - realizuje wiele metod, które wykorzystują metodę each do iterowania po elementach
 - index_by() - konwertuje na tablicę asocjacyjną
 - łączenie elementów w kawałki
 
```ruby
 [3,1,4,1,5,9,2,6,5,3,5].chunk { |n| n.even? }.each { |even, ary| p [even, ary] }

 [false, [3, 1]]
 [true, [4]]
 [false, [1, 5, 9]]
 [true, [2, 6]]
 [false, [5, 3, 5]]
 ```

 - szukanie pierwszego elementu spełniającego zadane warunki
 
```ruby
 (1..10).detect { |i| i % 2 == 0 and i % 3 == 1 }
 => 4
 ```

 - pętla
 
```ruby
 (1..5).cycle(2) { |a| print a.to_s+', ' }
 1, 2, 3, 4, 5, 1, 2, 3, 4, 5,
 ```

 - each_cons(n) - iteruje dany blok i zwraca n-elementowe
 
```ruby
 (1..5).each_cons(3) { |a| p a }

 [1, 2, 3]
 [2, 3, 4]
 [3, 4, 5]
 ```

 - each_slice(n) - dzieli blok na n-elementowe tablice
 
 ```ruby
 [1, 5, 8, 2, 1, 3, 8].each_slice(2) { |a| p a }

 [1, 5]
 [8, 2]
 [1, 3]
 [8]
 ```

 - grupowanie
 
 ```ruby
 (1..20).group_by { |i| i%5 }
 => {1=>[1, 6, 11, 16], 2=>[2, 7, 12, 17], 3=>[3, 8, 13, 18], 4=>[4, 9, 14, 19], 0=>[5, 10, 15, 20]}
 ```

 - slice_after(n) - dzielenie po wystąpieniu n
 
 ```ruby
 [1, 4, 7, 3, 4, 6].slice_after(4).to_a
 => [[1, 4], [7, 3, 4], [6]]
 ```

 - slice_when {|elt_before, elt_after| bool }
 
```ruby
 a = [3, 11, 14, 25, 28, 29, 29, 41, 55, 57]
 p a.slice_when {|i, j| j%i > 3 }.to_a
 => [[3, 11, 14], [25, 28, 29, 29], [41], [55, 57]]
 ```

 - sort_by
 
```ruby
 %w{lisek, kot, sowa}.sort_by { |word| word.length}
 => ["kot", "sowa", "lisek"]
 ```