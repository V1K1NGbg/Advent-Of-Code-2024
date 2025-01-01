// rustc 9.1.rs --crate-name 91
// ./91

use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    let file = File::open("input/9.txt").unwrap();
    let line = BufReader::new(file).lines().next().unwrap().unwrap();
    let dig = line.chars()
        .map(|c| c.to_digit(10).unwrap() as i32)
        .collect::<Vec<_>>();

    let mut parts = Vec::new();
    let mut file_id = 0;
    let mut is_file = true;
    for &d in &dig {
        if is_file {
            if d > 0 {
                parts.extend(std::iter::repeat(file_id).take(d as usize));
            }
            file_id += 1;
        } else {
            if d > 0 {
                parts.extend(std::iter::repeat(-1).take(d as usize));
            }
        }
        is_file = !is_file;
    }

    loop {
        let mut moved = false;
        for i in (0..parts.len()).rev() {
            if parts[i] != -1 {
                if let Some(j) = (0..i).find(|&x| parts[x] == -1) {
                    parts[j] = parts[i];
                    parts[i] = -1;
                    moved = true;
                    break;
                }
            }
        }
        if !moved {
            break;
        }
    }

    let mut checksum = 0;
    for (i, &b) in parts.iter().enumerate() {
        if b >= 0 {
            checksum += i as i64 * b as i64;
        }
    }
    println!("{}", checksum);
}