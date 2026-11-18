_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (x * i));
        acc = (acc ^ (((i & y) & (acc | i)) * ((4294967295u >> 23u) & (x ^ y))));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ ((586165217u << 27u) & (i >> 1u)));
            acc = (acc ^ ((acc | acc) + (y * i)));
        } else {
            acc = (acc ^ (((y >> 19u) + (x + 15u)) >> 14u));
            acc = (acc ^ (x & x));
        }
    }
    if ((((x ^ y) & 1048576u) == 0u)) {
        acc = (acc ^ ((acc * y) >> 17u));
    } else {
        acc = (acc ^ x);
        acc = (acc ^ (((acc + y) ^ acc) | ((y + 2u) >> 0u)));
    }
    return acc;
}
