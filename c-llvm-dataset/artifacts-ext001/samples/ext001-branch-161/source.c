_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 536870912u) == 0u)) {
        acc = (acc ^ (acc & 1u));
    } else {
        acc = (acc ^ (y >> 28u));
        acc = (acc ^ ((x ^ (acc * x)) ^ acc));
    }
    acc = (acc ^ x);
    return acc;
}
