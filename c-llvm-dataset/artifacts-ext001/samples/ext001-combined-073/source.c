_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x - x));
        if (((((x ^ y) ^ i) & 536870912u) == 0u)) {
            acc = (acc ^ (0u & 0u));
            acc = (acc ^ ((i * 0u) >> 12u));
        } else {
            acc = (acc ^ (x << 31u));
        }
    }
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ (acc * ((y - acc) ^ (y << 6u))));
        acc = (acc ^ (((acc - x) + 698975858u) - ((3u + x) + (x + 7u))));
    }
    return acc;
}
