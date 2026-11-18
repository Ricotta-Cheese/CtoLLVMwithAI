_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((x >> 8u) ^ (7u >> 10u)) | ((4294967295u << 21u) >> 2u)));
    acc = (acc ^ (((acc & acc) << 5u) & ((y & acc) >> 14u)));
    acc = (acc ^ (y ^ x));
    return acc;
}
