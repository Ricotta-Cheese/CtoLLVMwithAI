_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 4194304u) == 0u)) {
        acc = (acc ^ (((x << 25u) & 0u) | ((y - x) | (acc - y))));
    } else {
        acc = (acc ^ (y * acc));
        acc = (acc ^ (x + 16u));
    }
    acc = (acc ^ ((acc & x) & x));
    return acc;
}
