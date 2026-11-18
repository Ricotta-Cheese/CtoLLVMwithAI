_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ acc);
        acc = (acc ^ (((x * y) >> 18u) - ((acc - acc) + (y * acc))));
        acc = (acc ^ (x + y));
        if (((((x ^ y) ^ i) & 16777216u) == 0u)) {
            acc = (acc ^ ((2u * x) - ((106641914u >> 26u) | (i ^ 3u))));
            acc = (acc ^ (y + acc));
        } else {
            acc = (acc ^ ((4294967295u ^ x) << 19u));
        }
    }
    if ((((x ^ y) & 32768u) == 0u)) {
        acc = (acc ^ (31u * 709689551u));
        acc = (acc ^ (y + x));
    } else {
        acc = (acc ^ (y * y));
        acc = (acc ^ (y + acc));
    }
    return acc;
}
