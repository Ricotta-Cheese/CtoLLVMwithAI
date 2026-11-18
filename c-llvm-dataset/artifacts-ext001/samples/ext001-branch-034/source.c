_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ ((y - x) ^ (x + acc)));
    } else {
        acc = (acc ^ (34190785u + y));
        acc = (acc ^ y);
    }
    acc = (acc ^ y);
    return acc;
}
