_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ 458127157u);
    } else {
        acc = (acc ^ (acc & ((y ^ 0u) | (31u << 26u))));
        acc = (acc ^ ((3715587316u * y) * (4294967295u & y)));
    }
    acc = (acc ^ y);
    return acc;
}
