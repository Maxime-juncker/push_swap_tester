#!/bin/bash

ITERATIONS=100							# number of time push swap will be tested
NB_ARGS=100								# size of the stack
PUSH_SWAP_PATH=../push_swap				# path of push_swap executable

AVRG=0
MAX=0
TRY=0

rm tester.log

printf "\n\033[0m\e[?25l---------------------------------\n"
printf "\033[33mtesting $NB_ARGS\033[33m random numbers $ITERATIONS\033[33m times\n\n\033[0m"

echo "tester settings: $NB_ARGS random numbers $ITERATIONS times" >> tester.log
printf "=============================================\n\n" >> tester.log

for i in $(seq 1 $ITERATIONS);
do
	TRY=$(python3 rand_numbers.py $NB_ARGS)
	COUNT=$(ARG="$(echo $TRY)"; "$PUSH_SWAP_PATH" $ARG | wc -l)
	AVRG=$((AVRG + COUNT))
	if [ $COUNT -gt $MAX ]; then
		MAX=$COUNT
		printf "push_swap score: \e[31m$COUNT\t(new max)\e[0m\n"
		printf "push_swap score: [$COUNT]\nnumbers: $TRY\n" >> tester.log
		echo "----------------------------------------------" >> tester.log
	else
		printf "push_swap score: \e[32m$COUNT\t[$(echo "scale=2; ($i / $ITERATIONS) * 100" | bc)%%]\e[0m\r"
	fi
done

printf "\n\n\033[33m---------------------------------\n"
printf "results:\n"
printf "\nmax: \e[34m$MAX\n"

# printing average
AVRG=$(echo "scale=1; $AVRG/$ITERATIONS" | bc)
printf "\033[33maverage: \033[34m$AVRG\n"

printf "\033[33m---------------------------------\n\e[?25h\n"


printf "\nsession results:\n" >> tester.log
printf "max: $MAX\n" >> tester.log
printf "average: $AVRG\n" >> tester.log
printf "\n----------------------------------------------\n" >> tester.log
