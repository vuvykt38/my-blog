# n = 84.to_s
# array =[]
# n.split(//).each do |i|
#   array << i.to_i
# end
# result = 0
# i = 0
# while i < array.size
#   result += array[i] * array[i]
#   i += 1
# end
# p result

def sum_square(n)
  array =[]
  n.to_s.split(//).each do |i|
    array << i.to_i
  end
  result = 0
  i = 0
  while i < array.size
    result += array[i] * array[i]
    i += 1
  end
  result
end

def is_happy(n, loop_time)
  loop_time += 1
  p n = sum_square(n)
  return false if loop_time > 10
  return true if n == 1
  is_happy(n, loop_time)
end

p is_happy(7, 0)