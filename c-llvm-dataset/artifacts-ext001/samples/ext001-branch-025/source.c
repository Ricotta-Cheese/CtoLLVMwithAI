_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ (y * x));
    } else {
        acc = (acc ^ (acc >> 25u));
    }
    acc = (acc ^ (((acc >> 13u) + (acc + x)) & acc));
    return acc;
}
