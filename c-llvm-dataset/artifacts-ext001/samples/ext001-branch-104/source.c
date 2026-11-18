_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1073741824u) == 0u)) {
        acc = (acc ^ x);
        acc = (acc ^ (((y + x) | (31u - 7u)) - ((acc ^ 4294967295u) + (acc - acc))));
    } else {
        acc = (acc ^ (acc << 16u));
        acc = (acc ^ (y << 27u));
    }
    acc = (acc ^ ((x - x) >> 8u));
    return acc;
}
