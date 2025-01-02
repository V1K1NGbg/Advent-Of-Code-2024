// g++ -o 11.2 11.2.cpp
// ./11.2

#include <iostream>
#include <map>
#include <cmath>
#include <vector>
#include <fstream>


std::pair<long, long> split_number(long num) {
    int num_digits = static_cast<int>(std::log10(num)) + 1;
    int half = num_digits / 2;
    long divisor = static_cast<long>(std::pow(10, half));
    long left = num / divisor;
    long right = num % divisor;
    return {left, right};
}

void blink(std::map<long, long>& stone_counts, int blinks) {
    for (int b = 0; b < blinks; ++b) {
        std::map<long, long> next_state;

        for (const auto& [stone, count] : stone_counts) {
            if (stone == 0) {
                next_state[1] += count;
            } else {
                int num_digits = static_cast<int>(std::log10(stone)) + 1;
                if (num_digits % 2 == 0) {
                    auto [left, right] = split_number(stone);
                    next_state[left] += count;
                    next_state[right] += count;
                } else {
                    next_state[stone * 2024] += count;
                }
            }
        }
        stone_counts = std::move(next_state);

        long total_stones = 0;
        for (const auto& [_, count] : stone_counts) {
            total_stones += count;
        }
    }
}

int main() {
    std::ifstream inputFile("input/11.txt");

    std::map<long, long> stone_counts;

    std::vector<long> stones;
    long stone;
    while (inputFile >> stone) {
        stones.push_back(stone);
        if (inputFile.peek() == '\n') {
            break;
        }
    }
    for (long s : stones) {
        stone_counts[s]++;
    }

    int blinks = 75;

    blink(stone_counts, blinks);

    long sum = 0;
    for (const auto& [_, count] : stone_counts) {
        sum += count;
    }

    std::cout << sum << std::endl;

    return 0;
}
