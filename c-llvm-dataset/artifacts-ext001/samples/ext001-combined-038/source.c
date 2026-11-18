_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x & acc));
        if (((((x ^ y) ^ i) & 131072u) == 0u)) {
            acc = (acc ^ ((7u - i) << 5u));
            acc = (acc ^ (((acc >> 14u) >> 1u) | ((acc | acc) ^ (i ^ 15u))));
        } else {
            acc = (acc ^ (((y + 3u) << 7u) - ((x ^ 4294967295u) & (acc | i))));
        }
    }
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ (3u - 0u));
    } else {
        acc = (acc ^ ((y + 2922470387u) | (3u * acc)));
        acc = (acc ^ ((39878205u ^ 805634567u) * (y * x)));
    }
    return acc;
}
