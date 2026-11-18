_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ 31u);
        acc = (acc ^ ((3u + acc) * acc));
    } else {
        acc = (acc ^ (16u * acc));
    }
    acc = (acc ^ (((16u * y) + 1200041249u) << 29u));
    return acc;
}
