_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y + acc));
        acc = (acc ^ (((y << 1u) >> 30u) | ((x ^ 31u) - (acc - 3u))));
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ y);
        } else {
            acc = (acc ^ ((y | x) * ((i * acc) >> 17u)));
            acc = (acc ^ (i | x));
        }
    }
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ 7u);
    }
    return acc;
}
