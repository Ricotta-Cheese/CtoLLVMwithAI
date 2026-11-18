_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (y >> 7u));
    } else {
        acc = (acc ^ (x & acc));
        acc = (acc ^ (y + ((x | y) * (acc & x))));
    }
    acc = (acc ^ (16u & 2737172463u));
    return acc;
}
