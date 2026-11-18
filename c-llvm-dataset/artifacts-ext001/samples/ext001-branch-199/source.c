_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ ((0u + 15u) << 14u));
        acc = (acc ^ 1457365640u);
    } else {
        acc = (acc ^ (x | acc));
        acc = (acc ^ y);
    }
    acc = (acc ^ (((y & acc) ^ (y << 4u)) >> 26u));
    return acc;
}
