
  def self.max_length_subset(set, n, sum)
    # The value of subset[i][j] will be
    # true if there is a subset of
    # set[0..j-1] with sum equal to i
    subset = []

    # Loop to create 2D array using 1D array
    (sum + 1).times {  |i| subset[i] = [] }

    count = []

    # Loop to create 2D array using 1D array
    (sum + 1).times { |i| count[i] = [] }

    # If sum is 0, then answer is true
    (n + 1).times { |i|
      subset[0][i] = true
      count[0][i] = 0
    }

    # If sum is not 0 and set is empty,
    # then answer is false
    (1..sum).each { |i|
      subset[i][0] = false
      count[i][0] = -1
    }

    # Fill the subset table in bottom up manner
    (1..sum).each { |i|
        (1..n).each { |j|
            subset[i][j] = subset[i][j - 1]
            count[i][j] = count[i][j - 1]

            if i >= set[j - 1]
                subset[i][j] = subset[i][j] || subset[i - set[j - 1]][j - 1]

                if subset[i][j]
                    count[i][j] = [count[i][j - 1], count[i - set[j - 1]][j - 1] + 1].max
                end
            end
        }
    }
    return count[sum][n]
  end
