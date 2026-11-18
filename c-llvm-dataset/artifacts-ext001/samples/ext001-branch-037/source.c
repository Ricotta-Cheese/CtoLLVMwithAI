_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 4096u) == 0u)) {
        acc = (acc ^ ((x << 24u) & (y >> 30u)));
        acc = (acc ^ ((x & y) | (4294967295u | x)));
    } else {
        acc = (acc ^ ((0u * acc) * x));
    }
    acc = (acc ^ (acc & x));
    return acc;
}
