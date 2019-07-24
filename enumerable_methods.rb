module Enumerable
  #each
    def my_each
      index = 0
      while index < self.length
        yield(self[index])
        index += 1
      end
    end
  
  #each_with_index
    def my_each_with_index
      index = 0
      while index < self.length
        yield(self[index],index)
        index += 1
      end
    end
  
  #select
    def my_select
      new_arr = Array.new()
      self.my_each {|mine| new_arr << mine if yield(mine)}
      new_arr
    end
  
  #all?
    def my_all?
      result = false
      self.my_each {|mine| yield(mine) ? result = true : result = false }
      result
    end
  
  #any?
    def my_any?
      result = false
      self.my_each {|mine| result = true if yield(mine)}
      result
    end
  
  #none
    def my_none?
      result = true
      self.my_each {|mine| result = false if yield(mine)}
      result
    end
  
  #count
    def my_count num = nil
      count = 0
        if num 
          self.my_each {|mine| count += 1 if mine == num}
        elsif block_given?
          self.my_each {|mine| count += 1 if yield(mine)}
        else
          count = self.length
        end 
      count
    end
  
  #map 
    def my_map block = nil
      new_arr = Array.new()
      if block
        self.my_each_with_index {|mine,index| new_arr[index] = block.call(mine)}
      else
        self.my_each_with_index {|mine,index| new_arr[index] = yield(mine)}
      end
      new_arr
    end
  
  #inject
    def my_inject initial = nil
      initial == nil ? result = self[0] : result = initial
  
      for i in 1..self.length - 1 
        result = yield(result,self[i])
      end 
      result
    end
  end
  
  
  test_arr = [100,54,1,2,3,4]
  
  #each
  #test_arr.each {|num| puts num*2}
  #test_arr.my_each {|num| puts num*2}
  
  #each_with_index
  #test_arr.each_with_index {|num,i| puts num + i}
  #test_arr.my_each_with_index {|num,i| puts num + i}
  
  #select
  #print test_arr.select {|num| num % 2 == 0}
  #print test_arr.my_select {|num| num % 2 == 0}
  
  #all?
  #print test_arr.all? {|num| num.is_a? Integer}
  #print test_arr.all? {|num| num.is_a? String}
  #print test_arr.my_all? {|num| num.is_a? Integer}
  #print test_arr.my_all? {|num| num.is_a? String}
  
  #any?
  #print test_arr.any? {|num| num.is_a? Integer}
  #print test_arr.any? {|num| num.is_a? String}
  #print test_arr.my_any? {|num| num.is_a? Integer}
  #print test_arr.my_any? {|num| num.is_a? String}
  
  #none?
  #print test_arr.none? {|num| num.is_a? String}
  #print test_arr.none? {|num| num.is_a? Integer}
  #print test_arr.my_none? {|num| num.is_a? String}
  #print test_arr.my_none? {|num| num.is_a? Integer}
  
  #count
  #print test_arr.count {|num| num < 4}
  #print test_arr.count(5)
  #print test_arr.count
  #print test_arr.my_count
  #print test_arr.my_count(5)
  #print test_arr.my_count {|num| num < 4}
  
  #map
  #print test_arr.map {|num| num * 10 }
  #test_block = Proc.new {|mine| mine * 10}
  #print test_arr.map(&test_block)
  #print test_arr.my_map {|num| num * 10 }
  #print test_arr.my_map(&test_block)
  
  #inject
  #print test_arr.inject {|result,mine| result + mine}
  #print test_arr.my_inject {|result,mine| result + mine}
  #def multiply_els arr
  #  arr.inject {|result,mine| result*mine }
  #  arr.my_inject {|result,mine| result*mine}
  #end
  #print multiply_els test_arr