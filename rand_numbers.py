import random
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("count", type=int)

args = parser.parse_args()

random_numbers = random.sample(range(-100000, 100000), args.count)

for n in random_numbers:
    print(n, end=" ")
