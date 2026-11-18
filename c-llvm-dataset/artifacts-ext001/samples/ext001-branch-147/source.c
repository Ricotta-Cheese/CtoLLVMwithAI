_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (acc >> 20u));
    } else {
        acc = (acc ^ (((16u | y) - x) >> 28u));
        acc = (acc ^ (((x * x) + (y - x)) - ((y + 2578850579u) - (x >> 11u))));
    }
    acc = (acc ^ y);
    return acc;
}
