CC=gcc
CFLAGS=-o grammar

build:
	jflex fisier.flex
	javac Fisier.java Rule.java
run:
	java Fisier input.txt
clean:
	rm -rf ./net/*.out
	rm -rf ./net/*.err
	rm -rf ./net/*.sorted
	rm -rf ./net/grammar
