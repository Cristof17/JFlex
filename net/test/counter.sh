#!/bin/bash
for i in $(seq 10 40); do
	cat syn$i.in
	#echo $i
	sleep 1;
done
