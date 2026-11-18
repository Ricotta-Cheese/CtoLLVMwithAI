_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (16u >> 28u));
    } else {
        acc = (acc ^ x);
        acc = (acc ^ (2663406785u & acc));
    }
    acc = (acc ^ ((x & y) & (x & x)));
    return acc;
}
