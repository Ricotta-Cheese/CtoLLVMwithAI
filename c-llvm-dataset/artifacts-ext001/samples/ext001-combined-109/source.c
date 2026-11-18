_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (31u + x));
        if (((((x ^ y) ^ i) & 4096u) == 0u)) {
            acc = (acc ^ (y * 4294967295u));
        } else {
            acc = (acc ^ (3537226199u >> 1u));
            acc = (acc ^ ((x & acc) - (3u + i)));
        }
    }
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (acc >> 3u));
    } else {
        acc = (acc ^ acc);
        acc = (acc ^ (((16u | y) * (1u << 1u)) | ((acc * 3u) ^ 1u)));
    }
    return acc;
}
