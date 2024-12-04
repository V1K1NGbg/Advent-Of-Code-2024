// node 3.1.js

const fs = require('fs');

fs.readFile('./3.txt', 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }

    let matches = data.match(/(mul\(\d+,\d+\))/g);
    let sum = 0;

    for (let match of matches) {
        let x = parseInt(match.split(',')[0].slice(4));
        let y = parseInt(match.split(',')[1].slice(0, -1));
        sum += x * y;
    }
    
    console.log(sum);
});