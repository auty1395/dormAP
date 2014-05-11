if [ $(ifconfig eth0 | grep -o 'RX\ bytes:[0-9]*' | sed s/^[^0-9]*//) -gt 2000000000 ] 
then
echo "Data cap exceeded"
echo "Generating new MAC..."
ifconfig eth0 down
ifconfig eth0 hw ether  00:1E:0C$(head -c 3 /dev/urandom | hexdump -ve '1/1 ":%.2X"')
ifconfig eth0 up
echo "Getting new IP..."
dhclient eth0
echo "Done!"

else 
echo "Data cap not yet reached."
fi
echo
