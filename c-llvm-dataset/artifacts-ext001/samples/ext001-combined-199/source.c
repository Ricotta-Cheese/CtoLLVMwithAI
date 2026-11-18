_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y + 4294967295u) & (i >> 9u)));
        acc = (acc ^ (acc | (x << 6u)));
        acc = (acc ^ (i ^ (acc - (i + 2367197218u))));
        if (((((x ^ y) ^ i) & 16u) == 0u)) {
            acc = (acc ^ (((y & 0u) - (1u + acc)) & ((y << 9u) * (x ^ acc))));
            acc = (acc ^ (((y * y) - (acc - acc)) << 11u));
        } else {
            acc = (acc ^ (((acc + 2886753417u) << 27u) << 24u));
            acc = (acc ^ (((i | acc) + (y - i)) - ((1u | 3u) * i)));
        }
    }
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ (((4294967295u << 10u) * 31u) | ((x - x) + 0u)));
    } else {
        acc = (acc ^ y);
        acc = (acc ^ acc);
    }
    return acc;
}
