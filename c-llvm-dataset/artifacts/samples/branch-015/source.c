_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 67108864u) == 0u)) {
        acc = (acc ^ acc);
        acc = (acc ^ (90006016u - (0u & x)));
    } else {
        acc = (acc ^ (((x << 15u) | (acc + y)) + (y + (y + acc))));
        acc = (acc ^ (y >> 0u));
    }
    acc = (acc ^ (y + (x | x)));
    return acc;
}
