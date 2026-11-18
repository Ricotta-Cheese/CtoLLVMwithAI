_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (3u - i));
        if (((((x ^ y) ^ i) & 1048576u) == 0u)) {
            acc = (acc ^ (acc - acc));
        } else {
            acc = (acc ^ (acc ^ 0u));
            acc = (acc ^ 1980159626u);
        }
    }
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (acc * x));
    } else {
        acc = (acc ^ (y & acc));
        acc = (acc ^ (y - ((3u >> 12u) - (x >> 23u))));
    }
    return acc;
}
