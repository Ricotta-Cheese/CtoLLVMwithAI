_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (((4294967295u >> 3u) ^ acc) * ((acc | acc) | (y ^ acc))));
    } else {
        acc = (acc ^ (x >> 15u));
    }
    acc = (acc ^ (x >> 14u));
    return acc;
}
