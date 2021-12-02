defmodule KVTest do
  use ExUnit.Case
  doctest KV

  test "find index up" do
    assert KV.findIUp([1,2,3,1,2,3], 2, 0, 5) == 2
    assert KV.findIUp([1,2,3,1,2,3], 1, 0, 5) == 1
    assert KV.findIUp([1,2,3,4,5,6], 5, 0, 5) == 5
    assert KV.findIUp([1,2,3,7,5,6], 5, 0, 5) == 3
    assert KV.findIUp([1,3,3,1], 1, 0, 3) == 1
    assert KV.findIUp([2,3,4,2], 1, 0, 3) == 1
    assert KV.findIUp([2,2,4,3], 3, 1, 3) == 2
  end

  test "find index down" do
    assert KV.findIDown([1,2,3,1,2,3], 2, 0, 5) == 4
    assert KV.findIDown([1,2,3,1,2,3], 1, 0, 5) == 3
    assert KV.findIDown([1,2,3,4,5,6], 5, 0, 5) == 4
    assert KV.findIDown([1,2,3,7,5,6], 5, 0, 5) == 4
    assert KV.findIDown([2,3,4,2], 1, 0, 3) == 3
  end

  test "find new pivot" do
    assert KV.findNewPivot(1, 2, 1) == 2
    assert KV.findNewPivot(1, 2, 2) == 1
    assert KV.findNewPivot(2, 2, 2) == 2
    assert KV.findNewPivot(1, 7, 4) == 4
  end

  test "swap elements" do
    assert KV.swapElements([1,1,1,1,2], 4, 1) == [1,2,1,1,1]
    assert KV.swapElements([1,1,1,1,2], 1, 4) == [1,2,1,1,1]

    assert KV.swapElements([2,3,4,2], 1, 3) == [2,2,4,3]
    assert KV.swapElements([2,2,4,3], 1, 3) == [2,3,4,2]
  end

  test "segregate array" do
    assert KV.segregateArray([2,3,4,2], 1, 0, 3) == {3, 2, [2,2,4,3]}
  end

  test "full sort package" do
    assert KV.sort([1,2,3,4,5,6,7,8,9]) == [1,2,3,4,5,6,7,8,9] # ordered list
    assert KV.sort([9,8,7,6,5,4,3,2,1]) == [1,2,3,4,5,6,7,8,9] # reversed list
    assert KV.sort([2,3,4,2]) == [2,2,3,4]
    assert KV.sort([1,3,3,1]) == [1,1,3,3]
    assert KV.sort([2,4,4,3]) == [2,3,4,4]
  end

  def stressTest(count, range) do
    array = KV.getRandomList(range, 1..range)
    trusted_array = Enum.sort(array)
    our_array = KV.sort(array)
    cond do
      our_array != trusted_array ->
        IO.inspect("An Error Has Occurred:")
        IO.inspect(trusted_array, label: "Sorted Array")
        IO.inspect(array, label: "Original Array")
        IO.inspect(our_array, label: "Our Array")
        false
      count > 0 -> stressTest(count - 1, range)
      true -> true
    end
  end

  @tag timeout: :infinity
  test "stress test" do
    assert stressTest(1, 10000)
  end
end
