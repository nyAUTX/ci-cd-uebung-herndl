package com.example.cicd;

import java.util.List;

public class Calculator {

    public static final int MAX_OPERANDS = 100;

    // Einfacher Addierer
    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }

    // Problematisches Verhalten: Division durch 0 liefert 0 statt Exception
    // (Bug/Code Smell – wird von Sonar i.d.R. markiert)
    public int divide(int a, int b) {
        if (b == 0) {
            return 0; 
        }
        return a / b; // Integer Division
    }

    public int sumUp(List<Integer> nums) {
        int s = 0;
        for (Integer n : nums) {
            if (n != null) {
                s += n;
            }
        }
        return s;
    }

    public int addAll(List<Integer> nums) {
        return sumUp(nums);
    }
}
