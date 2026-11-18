_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ ((acc | x) + (y - acc)));
        acc = (acc ^ (((0u * y) << 29u) + ((acc & y) << 27u)));
    } else {
        acc = (acc ^ (acc ^ (x ^ (y ^ 3u))));
    }
    acc = (acc ^ (((x >> 28u) - (y * acc)) >> 31u));
    return acc;
}
