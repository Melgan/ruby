require 'simplecov'
SimpleCov.start

require_relative '../lib/h_zad3'

describe Letter do

  let(:arg1) { "arg1" }
  let(:arg2) { "arg2" }
  let(:arg3) { "arg3" }
  let(:arg4) { "arg4" }

  it "is initialized with specified number of arguments" do
    expect { Letter.new() }.not_to raise_error
	expect { Letter.new(arg1) }.not_to raise_error
	expect { Letter.new(arg1, arg2) }.not_to raise_error
	expect { Letter.new(arg1, arg2, arg3) }.not_to raise_error
	expect { Letter.new(arg1, arg2, arg3, arg4) }.not_to raise_error
	expect { Letter.new(arg1, arg2, arg3, arg4, arg5) }.to raise_error
  end
 
  it "creates object Letter with specified arguments" do
    x = Letter.new(arg1, arg2, arg3, arg4)
    expect(x.znak).to eq(arg1)
    expect(x.ile).to eq(arg2)
    expect(x.left).to eq(arg3)
    expect(x.right).to eq(arg4)
  end 
end


describe "extractMin" do
  $start = nil 
  let(:a) {Letter.new("a", 1).add()}
  let(:b) {Letter.new("b", 4).add()}
  let(:c) {Letter.new("c", 2).add()}
  let(:e) {Letter.new("e", 3).add()}
  
  context 'without error' do
	subject {a}
	
    it "is defined" do
	  expect(subject).not_to be_nil
      expect { extractMin() }.not_to raise_error
    end
  end
	
  context 'find min and delete from queue' do
	subject { a; b; c; e}
    it "when min is the first element in the queue" do
      #queue:a(1)->b(4)->c(2)->e(3)
      #min: a, 1

      expect(subject).not_to be_nil
	  expect(search("a")).not_to be_nil
      expect(extractMin.znak).to eq("a")
	  expect(search("a")).to be_nil
    end
	
    it "when min is in the middle element of the queue" do
      #queue:b(4)->c(2)->e(3)
      #min: c, 2

	  expect(search("c")).not_to be_nil
      expect(extractMin.znak).to eq("c")
	  expect(search("c")).to be_nil
    end	
	
	it "when min is the last element in the queue" do
      #queue:b(4)->e(3)
      #min: e, 3

	  expect(search("e")).not_to be_nil
      expect(extractMin.znak).to eq("e")
	  expect(search("e")).to be_nil
    end	
	
	it "when there is only min in the queue" do
      #queue:b(4)
      #min: b, 4

	  expect(search("b")).not_to be_nil
      expect(extractMin.znak).to eq("b")
	  expect(search("b")).to be_nil
    end	
  end
end


describe "read" do
let(:tekst) { Array.new() }
let(:output) { ["a","b","b","c","d","e","e","e"] }
  it "is defined" do
	expect { read(tekst) }.not_to raise_error
  end

  it "takes from file InputEasy.txt text and put in the tab" do
    #file contains: abbcdeee
    read(tekst)
    expect(tekst).to eq(output)
  end
end


describe "add" do
  $start = nil
  let(:x){ Letter.new("x").add() }
  let(:y) { Letter.new("y").add() }
  let(:pom) { Letter.new("pom").add() }

  it "is defined" do   
    expect { subject{pom} }.not_to raise_error
  end	

  context 'good adding' do
	subject { x; y}  
    it "adds element to the end of queue" do
      expect(subject).not_to be_nil
	  expect(x.znak).to eq($start.znak)
	  expect(y.znak).to eq($start.nextL.znak)
    end
  end
end


describe "search" do
  $start = nil
  let(:x) { Letter.new("x").add() }
  
  it "is defined" do
    expect { search("w") }.not_to raise_error
  end

  it "returns nil when there is no element in the queue" do
    expect(search("b")).to be_nil
  end
  
  it "returns object when there is the element in the queue" do
    expect(search("x").znak).to eq("x")
  end
  
end


describe "licz" do
  let(:tekst) { ["a","b","b","c","d","e","e","e"] }
  
  it "is defined" do
    expect { licz(tekst) }.not_to raise_error
  end
  
  
  it "inserts into queue elements with chars" do
    $start = nil  
    licz(tekst)
    pom = $start
    expect(pom.znak).to eq("a")
    expect(pom.ile).to eq(1)
    pom = pom.nextL
    expect(pom.znak).to eq("b")
    expect(pom.ile).to eq(2)
    pom = pom.nextL
    expect(pom.znak).to eq("c")
    expect(pom.ile).to eq(1)
    pom = pom.nextL
    expect(pom.znak).to eq("d")
    expect(pom.ile).to eq(1)
    pom = pom.nextL
    expect(pom.znak).to eq("e")
    expect(pom.ile).to eq(3)
  end

end


describe "makeTree" do
  start= nil
  let(:a) { Letter.new("a", 1).add() }
  let(:b) { Letter.new("b", 2).add()  }
  let(:c) { Letter.new("c", 1).add()  }
  let(:d) { Letter.new("d", 1).add()  }
  let(:e) { Letter.new("e", 3).add()  }

  context 'without errors' do
    subject { a; b}	
    it "is defined" do
      expect(subject).not_to be_nil	
      expect { makeTree() }.not_to raise_error
    end
  end	
  
  it "makes huffman tree based on queue" do
  #structure:expected result
  #         ~
  #     /      \
  #    ~        ~
  #  /  \     /   \
  # d    b   ~     e
  #         /\
  #        a  c

    expect(subject).not_to be_nil
    makeTree() 
    expect($root.right.left.left.znak).to eq("a")
    expect($root.left.right.znak).to eq("b")
    expect($root.right.left.right.znak).to eq("c")
    expect($root.left.left.znak).to eq("d")
    expect($root.right.right.znak).to eq("e")
  end 
end


describe "inorder" do
  $start = nil 
  let(:a) { Letter.new("a", 1).add() }
  let(:b) { Letter.new("b", 4).add() }
  let(:c) { Letter.new("c", 4).add() }
  let(:d) { Letter.new("d", 1).add() }
  let(:e) {  Letter.new("e", 3).add() }
  let(:zz) { Letter.new("~", 3, a, c).add() }   
  let(:z) { Letter.new("~", 3, zz, e).add() }
  let(:y) { Letter.new("~", 3, d, b).add() }  
  let(:x) { Letter.new("~", 3, y, z).add() }

  context 'without errors' do
    subject { a; c; zz}	
    it "is defined" do
      expect(subject).not_to be_nil	
      $root=c   
      expect { inorder($root, [], 0) }.not_to raise_error
    end
  end 
  
  it "gives chars new shorter code which depend on the tree" do
  #there is
  #         ~
  #     /      \
  #    ~        ~
  #  /  \     /   \
  # d    b   ~     e
  #         /\
  #        a  c
  
    $root=x   
    expect { inorder($root, [], 0) }.not_to raise_error
    expect(search("a").kod).to eq([1,0,0])
    expect(search("b").kod).to eq([0,1])
    expect(search("c").kod).to eq([1,0,1])
    expect(search("d").kod).to eq([0,0])
    expect(search("e").kod).to eq([1,1])
  end  

end


describe "kodowanie" do
  let(:tekst){ ["a","b","b","c","d","e","e","e"] }
  let(:hcodes){ [] }
  let(:output) { [1,0,0,0,1,0,1,1,0,1,0,0,1,1,1,1,1,1] }
  let(:a) { Letter.new("a") }
  let(:b) { Letter.new("b") }
  let(:c) { Letter.new("c") }
  let(:d) { Letter.new("d") }
  let(:e) {  Letter.new("e") }
  
  context 'without errors' do
    subject { a; b}	
    it "is defined" do
	  a.kod = [1,0,0]
      b.kod = [0,1]
      a.nast = b
      $first=a 
      expect(subject).not_to be_nil	  
      expect { kodowanie(tekst, hcodes) }.not_to raise_error
    end
  end 

  it "returns to table hcodes result of coding text" do  
    a.kod = [1,0,0]
    b.kod = [0,1]
    c.kod = [1,0,1]
    d.kod = [0,0]
    e.kod = [1,1]
    a.nast = b
    b.nast = c
    c.nast = d
    d.nast = e
    $first=a    
    kodowanie(tekst, hcodes)	
    expect(hcodes).to eq(output)
  end   
end


describe "odkodowanie" do
  let(:a) { Letter.new("a", 1) }
  let(:b) { Letter.new("b", 4) }
  let(:c) { Letter.new("c", 4) }
  let(:d) { Letter.new("d", 1) }
  let(:e) {  Letter.new("e", 3) }
  let(:zz) { Letter.new("~", 3, a, c) }   
  let(:z) { Letter.new("~", 3, zz, e) }
  let(:y) { Letter.new("~", 3, d, b) }  
  let(:x) { Letter.new("~", 3, y, z) }
  let(:hcodes){ [1,0,0,0,1,0,1,1,0,1,0,0,1,1,1,1,1,1] }
  let(:hcodes1){ [1,0,1] }
  let(:uncode){ [] }
  let(:output){ ["a","b","b","c","d","e","e","e"] }

  it "is defined" do  
    $root=a     
    expect { odkodowanie(uncode, hcodes1) }.not_to raise_error
  end 
 
  it "returns to table uncode result of uncoding text" do   
    $root=x    
    odkodowanie(uncode, hcodes)   
    expect(uncode).to eq(output)
  end 
 
end


describe "printQ" do
  $start = nil
  let(:a) { Letter.new("a", 1).add() }
  let(:b) { Letter.new("b", 4).add() }
  let(:c) { Letter.new("c", 4).add() }

  it "is defined" do   
    expect { printQ() }.not_to raise_error
  end  
 
end


describe "printPomQ" do
  $start = nil
  let(:a) { Letter.new("a", 1) }
  let(:b) { Letter.new("b", 4) }
  let(:c) { Letter.new("c", 4) }

  it "is defined" do   
    a.kod = [1,0,0]
    b.kod = [0,1]
    c.kod = [1,0,1]
    a.nast = b
    b.nast = c
    $first=a 
    expect { printPomQ() }.not_to raise_error
  end  
 
end


describe "printTab" do
let(:tab) { [1,0,0,1,0,1] } 

  it "is defined" do    
    expect { printTab(tab) }.not_to raise_error
  end  
 
end

