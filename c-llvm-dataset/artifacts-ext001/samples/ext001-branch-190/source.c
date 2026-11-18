_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    if ((((x ^ y) & 32u) == 0u)) {
        acc = (acc ^ (((acc + acc) ^ (x ^ x)) | acc));
    } else {
        acc = (acc ^ (((y | 0u) + (acc + 201147517u)) >> 24u));
    }
    acc = (acc ^ ((y + 3u) << 21u));
    return acc;
}
