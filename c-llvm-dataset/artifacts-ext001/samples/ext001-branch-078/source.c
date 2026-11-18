_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ 2u);
        acc = (acc ^ (121423390u ^ (4294967295u << 17u)));
    } else {
        acc = (acc ^ (((x << 7u) | (y ^ acc)) | ((x ^ y) | (y >> 0u))));
    }
    acc = (acc ^ 7u);
    return acc;
}
