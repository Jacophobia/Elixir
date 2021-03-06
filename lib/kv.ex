defmodule KV do
  # WHILE array[beginning] < array[ar_pivot] AND beginning < end
  @spec findIUp(list(), integer(), integer(), integer()) :: integer()
  def findIUp(array, ar_pivot, ar_beg, ar_end) do
    if Enum.at(array, ar_beg) < Enum.at(array, ar_pivot) and ar_beg < ar_end do
      findIUp(array, ar_pivot, ar_beg + 1, ar_end)
    else
      ar_beg
    end
  end


  @spec findIDown(list(), integer(), integer(), integer()) :: integer()
  def findIDown(array, ar_pivot, ar_beg, ar_end) do
    if Enum.at(array, ar_end) >= Enum.at(array, ar_pivot) and ar_beg < ar_end do
      findIDown(array, ar_pivot, ar_beg, ar_end - 1)
    else
      ar_end
    end
  end


  @spec findNewPivot(integer(), integer(), integer()) :: integer()
  def findNewPivot(i_up, i_down, old_pivot) do
    cond do
      old_pivot == i_up -> i_down
      old_pivot == i_down -> i_up
      true -> old_pivot
    end
  end


  @spec _swapElements(list(), integer(), integer(), integer()) :: list()
  def _swapElements(array, i_one, i_two, i_curr) do
    if i_curr < Enum.count(array) do
      cond do
        i_curr == i_one -> [Enum.at(array, i_two)] ++ _swapElements(array, i_one, i_two, i_curr + 1)
        i_curr == i_two -> [Enum.at(array, i_one)] ++ _swapElements(array, i_one, i_two, i_curr + 1)
        true -> [Enum.at(array, i_curr)] ++ _swapElements(array, i_one, i_two, i_curr + 1)
      end
    else
      []
    end
  end


  @spec swapElements(list(), integer(), integer()) :: list()
  def swapElements(array, i_up, i_down) do
    _swapElements(array, i_up, i_down, 0)
  end


  @spec segregateArray(list(), integer(), integer(), integer()) :: tuple()
  def segregateArray(array, ar_pivot, ar_beg, ar_end) do
    if ar_beg < ar_end do
      i_up = findIUp(array, ar_pivot, ar_beg, ar_end)
      i_down = findIDown(array, ar_pivot, i_up, ar_end)

      swapped_array = swapElements(array, i_up, i_down)

      new_pivot = findNewPivot(i_up, i_down, ar_pivot)
      segregateArray(swapped_array, new_pivot, i_up, i_down)
    else
      {ar_pivot, ar_beg, array}
    end
  end


  # sortArray(array, beginning, end)
  @spec segregationSort(list(), integer(), integer()) :: list()
  def segregationSort(array, ar_beg, ar_end) do
    ar_pivot = trunc((ar_end + ar_beg) / 2)
    start = ar_beg
    finish = ar_end
    segregatedArray = segregateArray(array, ar_pivot, ar_beg, ar_end)

    segregated_pivot = elem(segregatedArray, 0)
    i_convergence = elem(segregatedArray, 1)
    segregated_array = elem(segregatedArray, 2)

    new_array = swapElements(segregated_array, i_convergence, segregated_pivot)
    new_pivot = i_convergence

    cond do
      new_pivot > start and new_pivot < finish -> segregationSort(new_array, start, new_pivot - 1) ++ [Enum.at(new_array, new_pivot)] ++ segregationSort(new_array, new_pivot + 1, finish)
      new_pivot > start -> segregationSort(new_array, start, new_pivot - 1) ++ [Enum.at(new_array, new_pivot)]
      new_pivot < finish -> [Enum.at(new_array, new_pivot)] ++ segregationSort(new_array, new_pivot + 1, finish)
      true -> [Enum.at(new_array, new_pivot)]
    end
  end


  # segregationSort(array)
  @spec sort(list()) :: list()
  def sort(array) do
    #   Identify the beginning and ending of the array you are working with.
    if Enum.count(array) > 1 do
      ar_beg = 0
      ar_end = Enum.count(array) - 1

      segregationSort(array, ar_beg, ar_end)
    else
      array
    end
  end


  def getRandomList(num_elements, enumerable) do
    if num_elements > 0 do
      [Enum.random(enumerable)] ++ getRandomList(num_elements - 1, enumerable)
    else
      []
    end
  end


  def main(count, range) do
    array = getRandomList(range, 1..range)
    trusted_array = Enum.sort(array)
    our_array = sort(array)
    cond do
      our_array != trusted_array ->
        IO.inspect("An Error Has Occurred:")
        IO.inspect(trusted_array, label: "Sorted Array")
        IO.inspect(array, label: "Original Array")
        IO.inspect(our_array, label: "Our Array")
        false
      count > 0 -> main(count - 1, range)
      true -> true
    end
  end
end
