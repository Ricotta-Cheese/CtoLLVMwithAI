_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((16u & x) * y) + ((i & acc) ^ (x + acc))));
        acc = (acc ^ i);
        acc = (acc ^ (y * acc));
        if (((((x ^ y) ^ i) & 2u) == 0u)) {
            acc = (acc ^ (x | y));
        } else {
            acc = (acc ^ (x + i));
            acc = (acc ^ (((1u - acc) << 8u) << 19u));
        }
    }
    if ((((x ^ y) & 8u) == 0u)) {
        acc = (acc ^ (acc | y));
    } else {
        acc = (acc ^ (acc ^ acc));
    }
    return acc;
}
