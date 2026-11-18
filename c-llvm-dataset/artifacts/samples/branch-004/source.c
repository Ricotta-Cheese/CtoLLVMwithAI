_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 256u) == 0u)) {
        acc = (acc ^ ((y & y) - acc));
    } else {
        acc = (acc ^ ((y ^ (acc - y)) & ((y + acc) ^ (x + acc))));
        acc = (acc ^ (x + y));
    }
    acc = (acc ^ 31u);
    return acc;
}
