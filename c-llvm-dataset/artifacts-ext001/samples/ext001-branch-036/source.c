_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ (((y >> 19u) >> 12u) ^ ((y | x) << 10u)));
    } else {
        acc = (acc ^ (((acc - 16u) << 22u) << 24u));
        acc = (acc ^ ((3u & x) << 14u));
    }
    acc = (acc ^ ((acc & 1u) | (16u * 3782571714u)));
    return acc;
}
