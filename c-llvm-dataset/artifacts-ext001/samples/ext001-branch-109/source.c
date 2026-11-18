_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 1073741824u) == 0u)) {
        acc = (acc ^ y);
    } else {
        acc = (acc ^ (acc + ((4294967295u ^ x) - (31u << 27u))));
        acc = (acc ^ (((acc << 9u) ^ (4294967295u * y)) * ((y << 5u) | (acc << 2u))));
    }
    acc = (acc ^ ((31u - acc) | (0u << 21u)));
    return acc;
}
