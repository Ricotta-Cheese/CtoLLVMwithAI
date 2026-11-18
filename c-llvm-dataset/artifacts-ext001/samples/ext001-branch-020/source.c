_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 16u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (((15u & y) | (7u + acc)) + acc));
    } else {
        acc = (acc ^ (x + (x - acc)));
        acc = (acc ^ (((acc - 4274238077u) ^ (4294967295u ^ 4294967295u)) & ((y >> 20u) << 22u)));
    }
    acc = (acc ^ ((x << 2u) + (x * acc)));
    return acc;
}
