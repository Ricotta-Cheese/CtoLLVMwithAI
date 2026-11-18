_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((x + 4294967295u) << 27u) * ((x >> 24u) + (2893520588u | i))));
        if (((((x ^ y) ^ i) & 256u) == 0u)) {
            acc = (acc ^ (((acc * x) * (y ^ x)) | (acc << 5u)));
        } else {
            acc = (acc ^ (y - (x >> 3u)));
        }
    }
    if ((((x ^ y) & 33554432u) == 0u)) {
        acc = (acc ^ (y ^ 16u));
        acc = (acc ^ (acc << 19u));
    } else {
        acc = (acc ^ (acc & ((y * y) * (x << 29u))));
        acc = (acc ^ (((4294967295u << 17u) << 26u) - ((acc + acc) - (x ^ x))));
    }
    return acc;
}
