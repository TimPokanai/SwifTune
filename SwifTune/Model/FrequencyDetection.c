//
//  FrequencyDetection.c
//  SwifTune
//
//  Created by Tim Pokanai on 2024-10-21.
//

#include "FrequencyDetection.h"

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define PI 3.14159265358979323846

// Using helper function to perform fft computation recursively
void fft(float* real, float* imag, int n) {
    if (n <= 1) {
        return;
    }
    
    int half = n / 2;
    float* even_real = (float*)malloc(half * sizeof(float));
    float* odd_real = (float*)malloc(half * sizeof(float));
    float* even_imag = (float*)malloc(half * sizeof(float));
    float* odd_imag = (float*)malloc(half * sizeof(float));
    
    for (int i = 0; i < half; i++) {
        even_real[i] = real[i * 2];
        even_imag[i] = imag[i * 2];
        odd_real[i] = real[i * 2 + 1];
        odd_imag[i] = imag[i * 2 + 1];
    }
    
    fft(even_real, even_imag, half);
    fft(odd_real, odd_imag, half);
    
    for (int k = 0; k < half; k++) {
        float twid_real = cos(-2 * PI * k / n) * odd_real[k] - sin(-2 * PI * k / n) * odd_imag[k];
        float twid_imag = cos(-2 * PI * k / n) * odd_imag[k] + sin(-2 * PI * k / n) * odd_imag[k];
        
        real[k] = even_real[k] + twid_real;
        imag[k] = even_imag[k] + twid_imag;
        
        real[k + half] = even_real[k] - twid_real;
        imag[k + half] = even_imag[k] - twid_imag;
    }
    
    free(even_real);
    free(even_imag);
    free(odd_real);
    free(odd_imag);
}
