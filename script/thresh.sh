thershold=5
usage=$(df -h  | awk 'NR==2 {print $5}' | sed 's/%//')

if [ $usage -gt $thershold ]
then
	echo "memory usage is HIGH"
else
	echo "memory usage is LOW"
fi
