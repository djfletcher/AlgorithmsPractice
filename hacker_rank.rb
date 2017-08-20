require 'set'

# WARMUP

# Source: https://www.hackerrank.com/challenges/mini-max-sum
# Given five positive integers, find the minimum and maximum values that can be
# calculated by summing exactly four of the five integers. Then print the respective
# minimum and maximum values as a single line of two space-separated long integers.
# Sample Input: 1 2 3 4 5
# Sample Output: 10 14

def mini_max(nums)
  sum = nums.reduce(:+)
  { min: sum - nums.max, max: sum - nums.min }
end

puts mini_max([1, 2, 3, 4, 5]) == { min: 10, max: 14 }


# Source: https://www.hackerrank.com/challenges/staircase
# Observe that its base and height are both equal to n, and the image is drawn
# using # symbols and spaces. The last line is not preceded by any spaces.
# Sample Input: 6
# Sample Output:
#      #
#     ##
#    ###
#   ####
#  #####
# ######

def print_staircase(n)
  spaces = n - 1
  while spaces >= 0
    puts " " * spaces + "#" * (n - spaces)
    spaces -= 1
  end
end

print_staircase(3)
print_staircase(6)


# Source: https://www.hackerrank.com/challenges/time-conversion`
# Given a time in -hour AM/PM format, convert it to military (-hour) time.
# Sample Input: 07:05:45PM
# Sample Output: 19:05:45

def military(timestring)
  hr, min, sec = timestring.split(':')
  if sec[-2..-1] == 'AM'
    "#{hr}:#{min}:#{sec[0...-2]}"
  else
    "#{hr.to_i + 12}:#{min}:#{sec[0...-2]}"
  end
end

puts military('07:05:45PM') == '19:05:45'
puts military('07:05:45AM') == '07:05:45'

# SEARCH

# Source: https://www.hackerrank.com/challenges/missing-numbers
# Numeros, the Artist, had two lists a and b, such that b was a permutation of a.
# Numeros was very proud of these lists. Unfortunately, while transporting them
# from one exhibition to another, some numbers were left out of b.
# Can you find the missing numbers?
# Sample Input:
# => a = [203 204 205 206 207 208 203 204 205 206]
# => b = [203 204 204 205 206 207 205 208 203 206 205 206 204]
# Sample Output: [204 205 206]

def missing_numbers(a, b)
  a_counts = count_occurences(a)
  b_counts = count_occurences(b)
  missing = []
  b.each do |i|
    missing << i if b_counts[i] != a_counts[i]
  end

  missing.uniq
end

def count_occurences(arr)
  counts = Hash.new { |h, k| h[k] = 0 }
  arr.each do |i|
    counts[i] += 1
  end
  counts
end

a = [203, 204, 205, 206, 207, 208, 203, 204, 205, 206]
b = [203, 204, 204, 205, 206, 207, 205, 208, 203, 206, 205, 206, 204]
puts missing_numbers(a, b) == [204, 205, 206]


# Source: https://www.hackerrank.com/challenges/pairs
# Given n integers, count the number of pairs of integers whose difference is k.
# Sample Input: k = 2, nums = [1, 5, 3, 4, 2]
# Sample Output: 3

def num_pairs(k, nums)
  counts = count_occurences(nums)
  pairs = 0
  nums.each do |i|
    if counts[i - k] > 0
      pairs += counts[i - k]
      counts[i] -= 1
    end
    if counts[i + k] > 0
      pairs += counts[i + k]
      counts[i] -= 1
    end
  end
  pairs
end

puts num_pairs(2, [1, 5, 3, 4, 2]) == 3
puts num_pairs(2, [1, 5, 3, 4, 4, 1, 2]) == 5
puts num_pairs(1, [1, 1, 1, 1, 0, 2]) == 8

# SORTING

# Source: https://www.hackerrank.com/challenges/fraudulent-activity-notifications
# HackerLand National Bank has a simple policy for warning clients about possible
# fraudulent account activity. If the amount spent by a client on a particular day
# is greater than or equal to 2x the client's median spending for the last d days,
# they send the client a notification about potential fraud. The bank doesn't send
# the client any notifications until they have at least d prior days of transaction data.

# Given the value of d and a client's total daily expenditures for a period of n days,
# find and print the number of times the client will receive a notification over all n days.
# Sample Input: d = 5, [2, 3, 4, 2, 3, 6, 8, 4, 5]
# Sample Output: 2

def fraudulent_activity(d, days)
  frauds = 0
  days.each_with_index do |day, idx|
    sorted = (idx < d ? quicksort(days[0...idx]) : quicksort(days[(idx - d)...idx]))
    median = get_median(sorted)
    frauds += 1 if median && day >= 2 * median
  end
  frauds
end

def quicksort(arr)
  return arr if arr.length <= 1
  left = []
  right = []
  pivot = arr.first

  arr[1..-1].each do |el|
    if el <= pivot
      left << el
    else
      right << el
    end
  end

  quicksort(left) + [pivot] + quicksort(right)
end

def get_median(arr)
  return nil if arr.empty?
  if arr.length.odd?
    arr[arr.length / 2]
  else
    (arr[(arr.length - 1) / 2] + arr[arr.length / 2]) / 2.0
  end
end

puts fraudulent_activity(5, [2, 3, 4, 2, 3, 6, 8, 4, 5]) == 2


# DYAMIC PROGRAMMING

# Source: https://www.hackerrank.com/challenges/coin-change
# Coin change problem => how many different ways are there to make change



# Source: https://www.hackerrank.com/challenges/candies
# Alice is a kindergarten teacher. She wants to give some candies to the children in her class.  All the children sit in a line (their positions are fixed), and each  of them has a rating score according to his or her performance in the class.  Alice wants to give at least 1 candy to each child. If two children sit next to each other, then the one with the higher rating must get more candies. Alice wants to save money, so she needs to minimize the total number of candies given to the children.
# Sample Input: student ratings = [1, 2, 2]
# Sample Output: 4
# Here 1, 2, 2 is the rating. Note that when two children have equal rating, they are allowed to have different number of candies. Hence optimal distribution will be 1, 2, 1.
