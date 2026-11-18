_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ 16u);
        acc = (acc ^ 3u);
    } else {
        acc = (acc ^ acc);
    }
    acc = (acc ^ (((y << 14u) & (3u | acc)) - ((x & acc) - (3906077809u - acc))));
    return acc;
}
