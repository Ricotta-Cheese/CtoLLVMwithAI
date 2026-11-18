_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ ((acc - y) ^ (x | 3u)));
        acc = (acc ^ ((y ^ acc) ^ (y | acc)));
    } else {
        acc = (acc ^ (((x * x) & (acc + acc)) | ((acc ^ y) & (x - x))));
        acc = (acc ^ ((x | y) - (acc & acc)));
    }
    acc = (acc ^ ((y << 9u) | (16u * x)));
    return acc;
}
