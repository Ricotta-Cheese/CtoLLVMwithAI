_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 8388608u) == 0u)) {
        acc = (acc ^ (acc + y));
    } else {
        acc = (acc ^ (x + 4294967295u));
        acc = (acc ^ (y + acc));
    }
    acc = (acc ^ (((0u << 4u) * (0u & y)) & ((y << 24u) >> 23u)));
    return acc;
}
