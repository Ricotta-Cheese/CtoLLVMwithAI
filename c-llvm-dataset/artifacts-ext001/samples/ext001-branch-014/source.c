_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 16384u) == 0u)) {
        acc = (acc ^ (4294967295u - acc));
    } else {
        acc = (acc ^ (((y & 31u) >> 14u) - ((x >> 20u) | (7u ^ x))));
        acc = (acc ^ ((x | acc) | (acc ^ y)));
    }
    acc = (acc ^ (2u & 730141977u));
    return acc;
}
