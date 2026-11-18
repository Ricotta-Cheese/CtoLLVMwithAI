_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ (((y >> 16u) ^ (3u ^ acc)) ^ acc));
        acc = (acc ^ y);
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (((acc << 15u) & (y | y)) * (y - (x | 4294967295u))));
    return acc;
}
