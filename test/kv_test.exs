defmodule KVTest do
  use ExUnit.Case
  doctest KV

  test "find index up" do
    assert KV.findIUp([1,2,3,1,2,3], 2, 0, 5) == 2
    assert KV.findIUp([1,2,3,1,2,3], 1, 0, 5) == 1
    assert KV.findIUp([1,2,3,4,5,6], 5, 0, 5) == 5
    assert KV.findIUp([1,2,3,7,5,6], 5, 0, 5) == 3
  end

  test "find index down" do
    assert KV.findIDown([1,2,3,1,2,3], 2, 0, 5) == 4
    assert KV.findIDown([1,2,3,1,2,3], 1, 0, 5) == 3
    assert KV.findIDown([1,2,3,4,5,6], 5, 0, 5) == 4
    assert KV.findIDown([1,2,3,7,5,6], 5, 0, 5) == 4
  end

  test "find new pivot" do
    assert KV.findNewPivot(1, 2, 1) == 2
    assert KV.findNewPivot(1, 2, 2) == 1
    assert KV.findNewPivot(2, 2, 2) == 2
    assert KV.findNewPivot(1, 7, 4) == 4
  end

  test "full sort package" do
    assert KV.sort([1,2,3,4,5,6,7,8,9]) == [1,2,3,4,5,6,7,8,9] # ordered list
    assert KV.sort([9,8,7,6,5,4,3,2,1]) == [1,2,3,4,5,6,7,8,9] # reversed list
  end
end
