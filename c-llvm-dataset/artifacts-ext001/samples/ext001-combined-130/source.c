_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        acc = (acc ^ (y + (acc + y)));
        if (((((x ^ y) ^ i) & 268435456u) == 0u)) {
            acc = (acc ^ ((15u | 15u) | i));
            acc = (acc ^ (acc | x));
        } else {
            acc = (acc ^ (3u & 15u));
        }
    }
    if ((((x ^ y) & 4u) == 0u)) {
        acc = (acc ^ (((15u << 30u) - (15u & 3205874463u)) ^ y));
        acc = (acc ^ (acc - y));
    } else {
        acc = (acc ^ (acc ^ y));
        acc = (acc ^ ((x + 2u) - (15u & 3u)));
    }
    return acc;
}
