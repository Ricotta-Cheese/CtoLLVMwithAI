_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ ((y + 3457853126u) + (2u - y)));
    } else {
        acc = (acc ^ (((x ^ x) & (acc ^ acc)) * ((7u * 0u) | (x ^ 2u))));
    }
    acc = (acc ^ ((y ^ x) + (x * acc)));
    return acc;
}
