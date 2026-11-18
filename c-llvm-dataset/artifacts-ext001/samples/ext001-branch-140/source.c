_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ ((1u + x) | ((y << 29u) ^ (acc * acc))));
        acc = (acc ^ ((x - y) << 3u));
    } else {
        acc = (acc ^ (((4294967295u >> 22u) << 31u) >> 8u));
    }
    acc = (acc ^ ((y ^ y) >> 27u));
    return acc;
}
