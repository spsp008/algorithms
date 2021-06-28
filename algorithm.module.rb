module AlgorithmModule

  class MaxLengthSubSet
    def self.store_result(v)
      @@result.push(v)
    end

    def self.store_subsets(arr, i, sum, p, dp)
      if (i == 0 && sum != 0 && dp[0][sum])
        p.push(arr[i])
        store_result(p)
        p = []
        return
      end

      if (i == 0 && sum == 0)
        store_result(p)
        p = []
        return
      end

      if (dp[i - 1][sum])
        b = []
        b  = b + p
        store_subsets(arr, i - 1, sum, b, dp)
      end

      if (sum >= arr[i].duration && dp[i - 1][sum - arr[i].duration])
        p.push(arr[i]);
        store_subsets(arr, i - 1, sum - arr[i].duration, p, dp)
      end
    end

    def self.find_all_subsets(arr, sum)
      n = arr.length
      @@result = []
      if (n == 0 || sum < 0)
        return []
      end

      dp =  Array.new(n) { Array.new(sum + 1) { false } }
      n.times {  |i| dp[i][0] = true }

      if (arr[0].duration <= sum)
        dp[0][arr[0].duration] = true
      end


      (1..(n - 1)).each { |i|
        (0..sum).each { |j|
          dp[i][j] = (arr[i].duration <= j) ? (dp[i - 1][j] || dp[i - 1][j - arr[i].duration]) : dp[i - 1][j]
        }
      }
      if (dp[n - 1][sum] == false)
        return []
      end

      p = []
      store_subsets(arr, n - 1, sum, p, dp)

      @@result.max {|res| res.length}
    end
  end

end
