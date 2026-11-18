_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ i);
        acc = (acc ^ x);
        acc = (acc ^ (i ^ (acc + x)));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ ((i & i) ^ (16u - 16u)));
            acc = (acc ^ (((0u * 7u) + (acc & acc)) & ((y ^ 3190631962u) ^ (x | x))));
        } else {
            acc = (acc ^ ((x << 5u) | ((y & i) + (y - x))));
        }
    }
    if ((((x ^ y) & 1073741824u) == 0u)) {
        acc = (acc ^ ((16u - (x - x)) ^ ((x & acc) - (31u << 7u))));
        acc = (acc ^ (((y | acc) - 7u) - ((2u | acc) & (x ^ acc))));
    } else {
        acc = (acc ^ (31u & acc));
        acc = (acc ^ ((y << 9u) - acc));
    }
    return acc;
}
