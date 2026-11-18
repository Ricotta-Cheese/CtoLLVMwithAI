_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ ((y - x) - (y | x)));
    } else {
        acc = (acc ^ (y >> 2u));
    }
    acc = (acc ^ (16u + 2536897957u));
    return acc;
}
