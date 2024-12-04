// node 3.2.js

const fs = require('fs');

fs.readFile('./3.txt', 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }

    let matches = data.match(/(mul\(\d+,\d+\)|do\(\)|don't\(\))/g);
    let flag = true;
    let sum = 0;

    for (let match of matches) {
        if (match == "do()") {
            flag = true;
        } else if (match == "don't()") {
            flag = false;
        } else if (flag == true) {
            let x = parseInt(match.split(',')[0].slice(4));
            let y = parseInt(match.split(',')[1].slice(0, -1));
            sum += x * y;
        }
    }

    console.log(sum);
});