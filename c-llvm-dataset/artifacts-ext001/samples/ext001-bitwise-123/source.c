_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x ^ y);
    acc = (acc ^ (((1u >> 0u) | (31u << 31u)) | ((y >> 13u) << 14u)));
    acc = (acc ^ y);
    acc = (acc ^ (((x ^ x) | (15u & x)) >> 15u));
    return acc;
}
