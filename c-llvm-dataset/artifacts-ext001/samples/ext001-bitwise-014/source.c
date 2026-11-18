_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (y >> 2u));
    acc = (acc ^ acc);
    acc = (acc ^ (((x << 24u) | acc) >> 17u));
    acc = (acc ^ (((3u >> 31u) << 30u) | (x | (7u << 13u))));
    return acc;
}
