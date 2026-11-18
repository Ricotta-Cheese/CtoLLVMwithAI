_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (y + acc));
    } else {
        acc = (acc ^ 0u);
    }
    acc = (acc ^ ((15u | 2341607853u) | (16u ^ x)));
    return acc;
}
