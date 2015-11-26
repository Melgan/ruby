class Letter 
  #kod[]
  #nextL, prevl - wslazniki do kolejki (w extractmin usuwane)
  #left, right - wskazniki do drzewa
  #nast - wskaznik do kolejki pomocniczej (do kodowania, by moc szybko poruszac sie po znakach)
  #total - ilosc wezlow w kolejce

  attr_accessor :znak, :ile, :kod, :nextL, :prevL, :left, :right, :nast, :total
  def initialize(znak = nil, ile = nil, left = nil, right = nil)
    @ile = ile
    @left = left
    @right = right
    @znak = znak
    @nextL = nil
    @pevL = nil
    @kod = []
    @nast = nil
	@total = 0
  end
  
   #dodanie na koniec kolejki litery
  def add()
    if $start == nil
      $start = self
	  $start.total = 0
    else
      pom = $start
      
      while pom.nextL != nil
        pom = pom.nextL
      end 
      
      pom.nextL = self
      self.prevL = pom
    end
	$start.total += 1
	return self
  end
end
$start, $root = nil #poczatek kolejki znakow, drzewa
$first = nil	#poczatek pomocniczej kolejki(do kodowania)


#read from InputEasy.txt
def read(tekst)
  read_file = File.open(File.dirname(__FILE__) + '/InputEasy.txt')
  read_file.each_char do |char|
    tekst << char
  end
end

def search(x)
  #szukanie znakow w kolejce
  pom = Letter.new()
  pom = $start
  while pom != nil
    return pom if pom.znak == x
    pom = pom.nextL
  end
  return nil
end

def licz(tekst)
  #przejscie calej tabeli tekst i utworzenie kolejki (przeliczenie wystepowania znakow)
  pom = Letter.new()
  (0...tekst.length).each do |i|
    pom = search(tekst[i])
    
    if pom == nil
      x = Letter.new(tekst[i], 1) 
      x.add()
    else
      pom.ile +=1
    end
    
  end
end

def printQ()
  #drukowanie kolejki (znak i ilosc wystapien)
  pom = $start
  while pom != nil
    puts "#{pom.znak}: #{pom.ile}"
    pom = pom.nextL
  end 
end

def extractMin()
  pom = $start
  min = $start
  
  while pom.nextL != nil
    pom = pom.nextL
    if min.ile>pom.ile
      min = pom
    end
  end
  
  if min == $start
    if $start.nextL != nil
      $start = $start.nextL 
	  $start.total = min.total
	end
  end
  
  if min.prevL != nil
    (min.prevL).nextL = min.nextL 
  end
  
  if min.nextL != nil
    (min.nextL).prevL = min.prevL 
  end  
  
  $start.total -= 1
  
  $start=nil if $start.total==0
  return min
end

def makeTree()
  #tworzy drzewo
  z = Letter.new()
  while $start.nextL != nil
    x = extractMin()
    y = extractMin()
    razem = x.ile + y.ile
    z = Letter.new("~", razem, x, y)
    z.add()
  end
  $root = z
end

def inorder(n, codes, lenc)
 
  #liczenie jaki znak ma jaki kod (w zaleznosci gdzie na drzewie sie znajduje)
  pom = Letter.new()
  if n.znak != "~" #czy jest to lisc?

    print "#{n.znak}: "
    
    (0...lenc).each do |i|
      print codes[i]
    end
    
    puts ""
    
    (0...lenc).each do |i|      
      n.kod[i] = codes[i]
    end

    if $first == nil
      $first = n
    else
      pom = $first
      while pom.nast != nil
        pom = pom.nast
      end
      pom.nast = n
    end
  
  else
    codes[lenc] = 0
    inorder(n.left, codes, lenc+1)
    
    codes[lenc] = 1
    inorder(n.right, codes, lenc+1)  
  end
end

def kodowanie(tekst, hcodes)
  (0...tekst.length).each do |i|
    pom = $first
    
    while pom.nast != nil && pom.znak != tekst[i]
      pom = pom.nast
    end
    if pom.znak == tekst[i]
       (0...pom.kod.length).each do |j|
         hcodes << pom.kod[j]
       end
    else
      puts "404" 
    end 
    
  end
end

def odkodowanie(uncode, hcodes)
  pom = $root
  (0...hcodes.length).each do |i|
    pom = pom.left if pom.left != nil && hcodes[i] == 0
    pom = pom.right if pom.right != nil && hcodes[i] == 1
    if pom.left == nil && pom.right == nil
      uncode << pom.znak
      pom = $root
    end
  end
end

def printTab(tab)
  (0...tab.length).each do |i|
    printf "#{tab[i]}"
  end 
  puts "\n------------"
end


def printPomQ()
  puts "test-----------"
  pom = $first
  while pom != nil
    puts "#{pom.znak} - #{pom.kod}"
    pom = pom.nast
  end
  puts "-------"
end

# main --------------------------------
tekst = Array.new() #tablica gdzie wczytuje sie tekst do zakodowania
uncode = Array.new() #tablica gdzie wpisywany jest wynik odkodowania
hcodes = Array.new() #tablica gdzie wpisuje sie wynik kodowania 
read(tekst)
printTab(tekst)
licz(tekst)
printQ()
makeTree()
inorder($root, [], 0)
printPomQ()
kodowanie(tekst, hcodes)
puts "_______________zakodowany tekst"
printTab(hcodes)
odkodowanie(uncode, hcodes)
puts "_________________odkodowany tekst"
printTab(uncode)
