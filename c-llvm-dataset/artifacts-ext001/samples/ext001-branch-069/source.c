_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ ((y & x) << 17u));
    } else {
        acc = (acc ^ ((y - (y ^ 3u)) | ((x | x) & (y ^ acc))));
        acc = (acc ^ x);
    }
    acc = (acc ^ (y & ((acc >> 21u) + (y | acc))));
    return acc;
}
