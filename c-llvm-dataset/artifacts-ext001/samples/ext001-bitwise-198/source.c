_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (((y ^ 3u) ^ (acc & 1u)) | ((acc & 2u) >> 13u)));
    acc = (acc ^ ((x >> 21u) & (y | x)));
    acc = (acc ^ ((x & 31u) & (y << 29u)));
    acc = (acc ^ (acc << 26u));
    return acc;
}
