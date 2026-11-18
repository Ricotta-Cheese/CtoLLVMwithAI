_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ ((x + acc) - (388424269u * y)));
        acc = (acc ^ (acc * y));
    } else {
        acc = (acc ^ (y - x));
        acc = (acc ^ (acc ^ ((y * y) >> 7u)));
    }
    acc = (acc ^ (x * acc));
    return acc;
}
