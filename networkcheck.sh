if [ $(ping -c1 -n -w1 8.8.8.8 | grep -o 100%)  ] 
then 
	echo "Unreachable. Trying again.."
	if [ $(ping -c10 -n 8.8.8.8 | grep -o 100%) ]
	then
		echo "still unreachable..."
		echo "scrambling MAC and reconnecting.."
		./macrandom.sh
	else 
		echo "network good"
	fi

else
echo "network good"
fi
echo
