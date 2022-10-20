def range(start, last) #1 , 5
    return [] if last < start
    [start] + range(start+1, last)
end

def exp1(base, ex)
    return 1 if ex == 0
    base * exp1(base, ex-1)
end

# p exp1(2, 4) # 16
# p exp1(3, 20) # ??
# p exp1(5000000, 0) # 1

def exp2(base, ex)
    return 1 if ex == 0
    return base if ex == 1
    if ex.even?
        exp2(base, (ex/2)) ** 2
    else
        base * (exp2(base, ((ex-1)/2))**2)
    end
end

# p exp2(2, 4) # 16
# p exp2(3, 20) # ??
# p exp2(5000000, 0) # 1

def deep_dup(arr)
    res = []
    arr.each do |ele|
        ele.kind_of?(Array) ? res << deep_dup(ele) : res << ele 
    end
    res
end

# arr = [1,2,[3,4,[5]]]
# p arr.object_id
# p arr[2].object_id
# p arr[2][2].object_id
# p new_arr = deep_dup(arr)
# p new_arr.object_id
# p new_arr[2].object_id
# p new_arr[2][2].object_id


def fib_it(n)
    return [1] if n == 1
    return [1, 1] if n == 2
    seq = [1, 1]

    (3..n).each do |i|
        seq << seq[-1] + seq[-2]
    end
    return seq
end

# p fib_it(20)
# p fib_it(1)
# p fib_it(2)

def fib_rec(n)
    return [1] if n == 1
    return [1, 1] if n == 2
    seq = fib_rec(n - 1)
    return seq << seq[-1]+ seq[-2]
end

# p fib_rec(20)
# p fib_rec(1)
# p fib_rec(2)

def b_search(arr, ele)
    return nil if arr.length == 0
    mid = arr.length / 2
    return mid if arr[mid] == ele
    left = arr[0...mid]
    right = arr[mid+1..-1]
    begin 
        ele > arr[mid] ? left.length + 1 + b_search(right, ele) : b_search(left, ele)
    rescue
        return nil 
    end
end

# p b_search([1,2,3,4,5,6,7,8,9,10], 7)
# p b_search([1,2,3,4,5,6,7,8,9,10], 11)
# p b_search([1,2,3,4,5,6,7,8,9], 9)
# p b_search([1,2,3,4,5,6,7,8,9], 1)

def subsets(arr)
    return [] if arr.length == 0
    output = [[], arr]
    return output if arr.length == 1
    (0...arr.length).each do |i|
        inclusive_subsets = subsets([arr[i]]) #element
        inclusive_subsets.each {|el| output << el}
        exclusive_subsets = subsets(arr - [arr[i]]) #everything but the element
        exclusive_subsets.each {|el| output << el}
    end
    return output.uniq
end

# p subsets([1,2,3])

def permutations(arr)
    return [] if arr.empty?
    return [arr] if arr.length == 1
    res = []
    odd_one = arr[0]
    perm = permutations(arr[1..-1])
    perm.each do |permutation|
        (0...permutation.length).each do |i|
            p_copy = deep_dup(permutation)
            res << p_copy.insert(i, odd_one)
            # res << permutation[0...i] + [odd_one] + permutation[i+1..-1]
        end
        p_copy = deep_dup(permutation)
        res << p_copy + [odd_one]
    end
    res
end

# p permutations([1,2,3,4,5])

# def factorial(n)
#     return 1 if n == 1
#     return n * factorial(n - 1)
# end

# p factorial(3)
require 'byebug'
def mergesort(arr)
    return [] if arr.length == 0
    return arr if arr.length == 1
    mid = arr.length / 2
    left = arr[0..mid-1]
    right = arr[mid..-1]
    left = mergesort(left)
    right = mergesort(right)
    merge_helper(left, right)
end

def merge_helper(left, right)
    res = []
    until left.length == 0 || right.length == 0
        if left[0] < right[0]
            res << left.shift
        else
            res << right.shift
        end
    end
    res += left + right
end

# arr1 = [1,3,5,7,9,2,4,6,8,10,12,14]

# p mergesort(arr1)



def greedy(num, coins)
    return [] if coins.empty?
    res = []
    coins[0]
    coin_count = num / coins[0]
    coin_count.times do 
        res << coins[0]
    end
    res += greedy(num % coins[0], coins[1..-1])
    return res
end

p greedy(39, [25, 10, 5, 1])