_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 524288u) == 0u)) {
        acc = (acc ^ (acc & ((acc ^ acc) ^ (y + acc))));
    } else {
        acc = (acc ^ (acc - acc));
        acc = (acc ^ (y << 1u));
    }
    acc = (acc ^ (((y >> 13u) << 4u) + ((3u | acc) >> 22u)));
    return acc;
}
