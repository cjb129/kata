def main()
	x = $stdin.read.to_f
	total = 5
	n = 5
	i = 1
	ans = 0
	
	while(total < x)
		n = n * 2
		total = total + n
	end
	
	total = total - n
	
	while(total < x)
		total += n/5
		ans += 1
	end
	
	arr = ["Sheldon\n", "Leonard\n", "Penny\n", "Rajesh\n", "Howard\n"]
	print arr[ans-1]
end

main()






