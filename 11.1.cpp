// g++ -o 11.1 11.1.cpp
// ./11.1

#include <iostream>
#include <fstream>
#include <vector>

int main()
{
    std::ifstream inputFile("input/11.txt");
    if (!inputFile) {
        std::cerr << "Unable to open file";
        return 1;
    }

    std::vector<long> stones;
    long stone;
    while (inputFile >> stone) {
        stones.push_back(stone);
        if (inputFile.peek() == '\n') {
            break;
        }
    }

    inputFile.close();

    for (int i = 0; i < 25; i++) {
        for (int j = 0; j < stones.size(); j++) {
            if (stones[j] == 0) {
                stones[j] = 1;
            } else if (std::to_string(stones[j]).length() % 2 == 0) {
                std::string stoneStr = std::to_string(stones[j]);
                int len = stoneStr.length();
                int mid = len / 2;
                long leftStone = std::stoi(stoneStr.substr(0, mid));
                long rightStone = std::stoi(stoneStr.substr(mid));
                stones[j] = leftStone;
                stones.insert(stones.begin() + j + 1, rightStone);
                j++;
            } else {
                stones[j] *= 2024;
            }
        }
    }
    
    std::cout << stones.size() << std::endl;

    return 0;
}