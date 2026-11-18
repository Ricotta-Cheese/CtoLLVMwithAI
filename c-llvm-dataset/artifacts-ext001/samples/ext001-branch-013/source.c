_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 262144u) == 0u)) {
        acc = (acc ^ (((y * 0u) & (acc ^ y)) + ((y << 4u) ^ acc)));
    } else {
        acc = (acc ^ ((x & y) << 31u));
    }
    acc = (acc ^ x);
    return acc;
}
