// javac AOC25.java
// java AOC25

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class AOC25 {

    static String readFile(String filename) {
        File file = new File(filename);
        FileInputStream fis;
        try {
            fis = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
        byte[] data = new byte[(int) file.length()];
        try {
            fis.read(data);
            fis.close();
            return new String(data, StandardCharsets.UTF_8);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
    public static void main(String[] args) {
        String inputFile = "input/25.txt";
        String rawFile = readFile(inputFile);

        Set<Product> keys = new HashSet<>();
        Set<Product> locks = new HashSet<>();
        for (String rawRepresentation : rawFile.split("\n\n")) {
            Product product = new Product(rawRepresentation.split("\n"));
            if (product.type.equals(ProductType.KEY)) {
                keys.add(product);
            } else {
                locks.add(product);
            }
        }

        Set<Set<Product>> uniquePairs = new HashSet<>();
        for (Product key: keys) {
            for (Product lock: locks) {
                if (!key.overlap(lock)) {
                    uniquePairs.add(Set.of(key, lock));
                }
            }
        }
        System.out.println(uniquePairs.size());

    }
}

enum ProductType {
    LOCK,
    KEY
}

class Product {
    private final String[] raw;
    private final char[][] rep;
    private final int[] pin;
    ProductType type;

    private ProductType detectType() {
        if (raw[0].equals("#####")) {
            return ProductType.LOCK;
        } else {
            return ProductType.KEY;
        }
    }

    private int[] read() {
        int[] heights = new int[5];
        for (int i = 0; i < 5; i++) {
            int columnHeight = 0;
            for (char[] row : rep) {
                if (row[i] == '#') {
                    columnHeight += 1;
                }
            }
            heights[i] = columnHeight;
        }
        return heights;
    }

    public Product(String[] raw) {
        this.raw = raw;
        this.type = detectType();
        String[] representationOnly;
        if (this.type.equals(ProductType.LOCK)) {
            representationOnly = Arrays.copyOfRange(raw, 1, raw.length);
        } else {
            representationOnly = Arrays.copyOfRange(raw, 0, raw.length - 1);
        }

        this.rep = new char[6][5];
        for (int i = 0; i < 6; i++) {
            this.rep[i] = representationOnly[i].toCharArray();
        }
        this.pin = read();
    }

    public boolean overlap(Product other) {
        assert !this.type.equals(other.type) : "Only products of different types can overlap";
        for (int i = 0; i < 5; i++) {
            if (this.pin[i] + other.pin[i] > 5) {
                return true;
            }
        }
        return false;
    }
}