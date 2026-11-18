_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    if ((((x ^ y) & 1024u) == 0u)) {
        acc = (acc ^ ((y + 15u) + acc));
        acc = (acc ^ ((acc ^ y) ^ (acc | x)));
    } else {
        acc = (acc ^ (2u ^ acc));
    }
    acc = (acc ^ (((15u - 4294967295u) >> 1u) << 19u));
    return acc;
}
