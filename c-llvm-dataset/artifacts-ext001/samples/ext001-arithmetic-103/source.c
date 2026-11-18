_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + ((590470720u - acc) - (2299170886u * y)));
    acc = (acc + ((x + (3585907102u + acc)) * ((7u * x) + (x - x))));
    return acc;
}
