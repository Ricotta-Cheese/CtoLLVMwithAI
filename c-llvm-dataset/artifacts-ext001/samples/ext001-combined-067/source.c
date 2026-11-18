_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (((457946969u | 7u) - (acc | 15u)) - ((x * y) ^ (x << 18u))));
        acc = (acc ^ (i >> 3u));
        if (((((x ^ y) ^ i) & 65536u) == 0u)) {
            acc = (acc ^ ((acc + 1u) << 17u));
        } else {
            acc = (acc ^ (x - i));
        }
    }
    if ((((x ^ y) & 134217728u) == 0u)) {
        acc = (acc ^ (acc << 29u));
    } else {
        acc = (acc ^ (y << 6u));
        acc = (acc ^ (y & ((y - 15u) * (x - 15u))));
    }
    return acc;
}
