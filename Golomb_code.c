#include <stdio.h>
#include <stdint.h>

static inline int my_clz(uint32_t x) {
    int count = 0;
    for (int i = 31; i >= 0; --i) {
        if (x & (1U << i))
            break;
        count++;
    }
    return count;
}

void exp_golomb_encode(int value) {
    
    uint32_t code_num = value + 1;
    
    int leading_zeros = my_clz(code_num);

    int bit_length = 32 - leading_zeros;

    for (int i = 0; i < bit_length - 1; ++i) {
        printf("0");
    }

    for (int i = bit_length - 1; i >= 0; --i) {
        printf("%d", (code_num >> i) & 1);
    }
    
    printf("\n");
}

int main() {
    int values[] = {0, 1, 2, 3, 4, 5, 7, 15};
    int n = sizeof(values) / sizeof(values[0]);

    printf("Exponential-Golomb(0) Encodings (Using CLZ):\n");
    for (int i = 0; i < n; ++i) {
        printf("Value: %d -> Encoding: ", values[i]);
        exp_golomb_encode(values[i]);
    }

    return 0;
}
