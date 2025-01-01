// rustc 9.2.rs --crate-name 92
// ./92

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

    let mut file_ids: Vec<i32> = parts.iter().filter(|&&x| x != -1).cloned().collect();
    file_ids.sort_unstable_by(|a, b| b.cmp(a));
    
    for &file_id in &file_ids {
        let flength = parts.iter().filter(|&&x| x == file_id).count();
        
        let cstart = parts.iter().position(|&x| x == file_id).unwrap();
        
        if cstart == 0 {
            continue;
        }
        
        if let Some(goal) = (0..=cstart - flength).find(|&x| {
            parts[x..x + flength].iter().all(|&y| y == -1)
        }) {
            for i in 0..flength {
                parts[goal + i] = file_id;
                parts[cstart + i] = -1;
            }
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