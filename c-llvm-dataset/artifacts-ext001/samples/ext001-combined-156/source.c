_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((y << 22u) << 19u));
        acc = (acc ^ i);
        acc = (acc ^ (i * acc));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (((1u >> 22u) << 15u) >> 30u));
            acc = (acc ^ (15u * ((16u * y) ^ (acc >> 22u))));
        } else {
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ (y | 0u));
    } else {
        acc = (acc ^ (16u * acc));
        acc = (acc ^ (x - ((acc * y) - (15u ^ 15u))));
    }
    return acc;
}
