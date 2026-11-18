_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ ((x - y) >> 29u));
        acc = (acc ^ (((acc * 3u) ^ (4294967295u | i)) & ((7u & y) * (1053758749u & x))));
        acc = (acc ^ (i * 2579808827u));
        if (((((x ^ y) ^ i) & 2097152u) == 0u)) {
            acc = (acc ^ (y ^ ((y - acc) ^ (16u - i))));
            acc = (acc ^ y);
        } else {
            acc = (acc ^ (((acc >> 0u) + y) + ((i >> 13u) >> 10u)));
            acc = (acc ^ (acc + y));
        }
    }
    if ((((x ^ y) & 128u) == 0u)) {
        acc = (acc ^ ((y & 4294967295u) * acc));
        acc = (acc ^ (15u >> 27u));
    } else {
        acc = (acc ^ x);
    }
    return acc;
}
