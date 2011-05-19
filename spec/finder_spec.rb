require "spec_helper"
require "finder"

describe Finder do
  include Finder
  
  it "should work with empty array" do
    find_missing([]).should == [1, 2]
  end
  
  it "should work with one element" do
    find_missing([1]).should == [2,3]
    find_missing([2]).should == [1,3]
    find_missing([3]).should == [1,2]
  end
  
  it "should detect elements outside array" do
    find_missing([1,2]).should == [3,4]
    find_missing([3,4]).should == [1,2]    
    find_missing([2,3,4,5]).should == [1,6]    
  end
  
  it "should work with" do
    find_missing([1,2,3]).should == [4,5]
    find_missing([1,3,5]).should == [2,4]
    find_missing([1,2,3,6,7]).should == [4,5]
    find_missing([1,2,3,4,5] - [1,3]).should == [1,3]
  end
  
  it "should work with long arrays" do
    ary = (1..1_000_000).to_a
    missing_values = [
      ary.delete_at(rand(ary.length)),
      ary.delete_at(rand(ary.length))
    ]
    find_missing(ary).should == missing_values.sort
  end
  
end
