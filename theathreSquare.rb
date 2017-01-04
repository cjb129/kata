#http://codeforces.com/problemset/problem/1/A
theatreWidth, theatreHeight, blockWidth = $stdin.read.split.map(&:to_f)
p (theatreWidth/blockWidth).ceil * (theatreHeight/blockWidth).ceil
