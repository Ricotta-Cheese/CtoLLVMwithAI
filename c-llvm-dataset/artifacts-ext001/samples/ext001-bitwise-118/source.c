_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((31u >> 3u) >> 6u) << 0u));
    acc = (acc ^ ((4294967295u | y) ^ (x >> 4u)));
    return acc;
}
