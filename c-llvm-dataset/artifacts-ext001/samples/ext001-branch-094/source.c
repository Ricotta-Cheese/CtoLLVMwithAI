_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 65536u) == 0u)) {
        acc = (acc ^ (7u << 15u));
    } else {
        acc = (acc ^ (((16u & x) * (3u >> 25u)) * ((acc - y) >> 14u)));
        acc = (acc ^ (acc ^ (15u * (2578640212u - y))));
    }
    acc = (acc ^ ((x * acc) >> 4u));
    return acc;
}
