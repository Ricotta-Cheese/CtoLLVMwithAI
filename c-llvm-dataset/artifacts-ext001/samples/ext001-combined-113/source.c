_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ 31u);
        acc = (acc ^ ((y - acc) & (4294967295u + i)));
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ (((0u + i) | (x * i)) ^ ((2778530457u << 16u) & (i * 1u))));
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (x * acc));
            acc = (acc ^ (((i | acc) ^ 7u) * (x | (acc * acc))));
        }
    }
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ ((acc + x) - (acc >> 11u)));
        acc = (acc ^ ((7u * 3u) * (15u - x)));
    } else {
        acc = (acc ^ (x | acc));
    }
    return acc;
}
