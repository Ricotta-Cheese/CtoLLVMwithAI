_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 2u) == 0u)) {
        acc = (acc ^ (((y * acc) ^ (16u >> 15u)) ^ ((x * x) ^ (acc - x))));
        acc = (acc ^ ((acc - acc) & (x << 15u)));
    } else {
        acc = (acc ^ ((1248526957u << 18u) - (acc ^ 3298249555u)));
    }
    acc = (acc ^ (((7u & y) - acc) | 1u));
    return acc;
}
