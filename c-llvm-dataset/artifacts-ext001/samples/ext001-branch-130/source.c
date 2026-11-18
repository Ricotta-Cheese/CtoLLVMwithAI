_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 4096u) == 0u)) {
        acc = (acc ^ acc);
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (((y >> 7u) * (x << 11u)) >> 6u));
    return acc;
}
