_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    for (unsigned int i = 0u; i < ((x & 15u) + (y & 1u)); ++i) {
        acc = (acc ^ (y | acc));
        acc = (acc ^ (x * ((31u << 29u) << 13u)));
        if (((((x ^ y) ^ i) & 512u) == 0u)) {
            acc = (acc ^ (((0u & acc) - (y * acc)) * ((y + x) ^ (x << 30u))));
            acc = (acc ^ i);
        } else {
            acc = (acc ^ (x - i));
            acc = (acc ^ acc);
        }
    }
    if ((((x ^ y) & 268435456u) == 0u)) {
        acc = (acc ^ (acc + acc));
        acc = (acc ^ 31u);
    } else {
        acc = (acc ^ (((y + y) + (acc >> 1u)) & y));
    }
    return acc;
}
