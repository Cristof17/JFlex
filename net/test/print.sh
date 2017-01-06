#!/bin/bash

for i in $(seq 10 50);do
	cat syn$i.in
	sleep 0.5
done
