# test/eigen_space_test.rb
require 'test/unit'
require 'json'
require_relative '../eigen_space'

# hashmaps compare properly with keys as symbolize_names
# 

class Eigen_space_test < Test::Unit::TestCase
  def test_hash_with_extentions
    ef = EigenFrame.new
    x = ef.eigen_padding(2,3)
    y = {:left=>2, :right=>2, :top=>3, :bottom=>3}
    assert x >= y, "#{x.inspect} >= #{y.inspect}"
  end

  def test_json_with_extentions
    ef = EigenFrame.new
    x = ef.eigen_padding(2,3).to_json
    x1 = JSON.parse(x, {:symbolize_names => true})
    y = {:bottom=>3, :left=>2, :right=>2, :top=>3}
    assert x1 >= y, "#{x1.inspect} >= #{y.inspect}"
  end
  
  
end
