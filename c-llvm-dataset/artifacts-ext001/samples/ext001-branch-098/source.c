_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (acc - acc));
    } else {
        acc = (acc ^ ((x + 31u) & (y - x)));
    }
    acc = (acc ^ ((x + y) - (15u | x)));
    return acc;
}
