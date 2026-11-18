_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ (y >> 2u));
        acc = (acc ^ (acc + 7u));
    } else {
        acc = (acc ^ (y ^ acc));
        acc = (acc ^ ((x << 1u) ^ 3u));
    }
    acc = (acc ^ (((y >> 0u) ^ (x >> 11u)) - ((y * y) | (acc * acc))));
    return acc;
}
