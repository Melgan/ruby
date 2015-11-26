
### Hash
*Tworzenie
 
```ruby
Hash['a', 1, 'b', 2, 'c', 3] # {"a"=>1, "b"=>2, "c"=>3}
Hash[[['a', 1], ['b', 2], ['c', 3]]] #  {"a"=>1, "b"=>2, "c"=>3}
Hash['a' => 1, 'b' => 2, 'c' => 3] # {"a"=>1, "b"=>2, "c"=>3}
```
Wartość domyślna
```ruby

h = {} # 
Lub 
h = Hash.new

h.default = 'go'
h = Hash.new('go')

h['a'] = 'ha'

h['c'] # => "go"
h['c'].upcase! # => "GO"
# zmieniona wartosc domyslna
h['d'] # => "GO"

h.keys # => ["a"]

# wartosc domyslna moze zalezec od klucza
h = Hash.new { |hash, key| hash[key] = "+#{key}" }

h['a'] = 'ha'
h.keys # => ["a"]

h['b'] # => "+b"
h.keys # => ["a", "b"]
```
Każdy element
```ruby
h = { 'A' => 'B', 'C' => 'D', 'E' => 'F' }
h.each { |key, value| puts "#{key} #{value}" }
# A B
# C D
# E F

h.each_key { |k| puts k }
# A
# C
# E

h.each_value { |v| puts v }
# B
# D
# F
```
Łączenie
```ruby
h = { 'A' => 'B', 'C' => 'D', 'E' => 'F' }
h1 = { 'A' => 'X', 'Y' => 'B' }
h.merge(h1) # {"A"=>"X", "C"=>"D", "E"=>"F", "Y"=>"B"}

h.merge!(h1)
h # {"A"=>"X", "C"=>"D", "E"=>"F", "Y"=>"B"}
```