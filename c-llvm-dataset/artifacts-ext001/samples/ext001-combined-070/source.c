_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y + x) ^ (1u << 1u)));
        acc = (acc ^ (acc * i));
        acc = (acc ^ (4294967295u + y));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ x);
        } else {
            acc = (acc ^ ((acc | x) & acc));
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (y | (y << 14u)));
    } else {
        acc = (acc ^ y);
        acc = (acc ^ x);
    }
    return acc;
}
