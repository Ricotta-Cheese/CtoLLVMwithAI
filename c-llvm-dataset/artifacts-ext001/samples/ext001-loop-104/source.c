_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((3u ^ (y << 21u)) ^ (i ^ (x + acc))));
        acc = (acc ^ (((acc + i) ^ (acc + i)) * ((acc >> 15u) - (x ^ 16u))));
    }
    return acc;
}
