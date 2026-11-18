_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (((y | acc) * 15u) | ((i & 0u) ^ (31u >> 15u))));
        acc = (acc ^ (i ^ i));
        if (((((x ^ y) ^ i) & 33554432u) == 0u)) {
            acc = (acc ^ ((i - y) & (x * acc)));
            acc = (acc ^ (x * i));
        } else {
            acc = (acc ^ (i * (x - y)));
        }
    }
    if ((((x ^ y) & 16777216u) == 0u)) {
        acc = (acc ^ (y >> 4u));
        acc = (acc ^ (acc * 4294967295u));
    } else {
        acc = (acc ^ (acc * acc));
        acc = (acc ^ 1u);
    }
    return acc;
}
