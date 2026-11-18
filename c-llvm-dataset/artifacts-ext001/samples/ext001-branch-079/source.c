_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ ((y - acc) ^ ((15u & y) - (y << 28u))));
        acc = (acc ^ ((y + acc) << 28u));
    } else {
        acc = (acc ^ (((x ^ acc) << 18u) - ((4294967295u + x) ^ (7u - acc))));
        acc = (acc ^ (((7u ^ acc) ^ (x ^ 31u)) * ((x | y) >> 13u)));
    }
    acc = (acc ^ y);
    return acc;
}
