_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (i << 11u));
        acc = (acc ^ (x * ((acc * acc) ^ (y << 3u))));
        if (((((x ^ y) ^ i) & 2147483648u) == 0u)) {
            acc = (acc ^ (x ^ i));
        } else {
            acc = (acc ^ i);
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ y);
        acc = (acc ^ (x * y));
    } else {
        acc = (acc ^ ((acc + y) + (y * y)));
    }
    return acc;
}
