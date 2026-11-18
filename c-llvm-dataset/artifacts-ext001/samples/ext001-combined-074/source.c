_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((4294967295u - i) ^ (3u >> 3u)));
        acc = (acc ^ i);
        if (((((x ^ y) ^ i) & 4u) == 0u)) {
            acc = (acc ^ ((y << 12u) - (x | 3705599855u)));
        } else {
            acc = (acc ^ 31u);
        }
    }
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (((x | 31u) & (acc - y)) + (acc >> 11u)));
        acc = (acc ^ ((acc << 25u) << 5u));
    } else {
        acc = (acc ^ ((x & acc) - acc));
    }
    return acc;
}
