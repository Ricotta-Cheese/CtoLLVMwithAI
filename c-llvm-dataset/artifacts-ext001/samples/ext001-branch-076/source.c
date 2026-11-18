_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ ((16u * acc) | (x - acc)));
    } else {
        acc = (acc ^ (acc & y));
    }
    acc = (acc ^ (((348946651u ^ 4198596168u) * (acc >> 3u)) << 5u));
    return acc;
}
