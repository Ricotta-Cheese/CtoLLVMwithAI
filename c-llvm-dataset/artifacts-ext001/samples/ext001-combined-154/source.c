_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x & y) & y));
        acc = (acc ^ (i << 25u));
        if (((((x ^ y) ^ i) & 2147483648u) == 0u)) {
            acc = (acc ^ (15u & y));
            acc = (acc ^ ((i << 12u) + (4294967295u & 4189981385u)));
        } else {
            acc = (acc ^ 15u);
        }
    }
    if ((((x ^ y) & 8192u) == 0u)) {
        acc = (acc ^ (((y | x) * (x + acc)) - ((x * 7u) * (acc - acc))));
        acc = (acc ^ ((y * acc) - (0u * acc)));
    } else {
        acc = (acc ^ (((y + y) << 5u) | (x >> 0u)));
    }
    return acc;
}
