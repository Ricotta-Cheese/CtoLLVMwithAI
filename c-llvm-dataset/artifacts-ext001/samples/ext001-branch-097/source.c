_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 2147483648u) == 0u)) {
        acc = (acc ^ ((acc >> 3u) * (351205374u + 4294967295u)));
        acc = (acc ^ (((y | 31u) ^ (16u << 16u)) << 21u));
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (y & ((y - 1u) ^ (15u | acc))));
    return acc;
}
