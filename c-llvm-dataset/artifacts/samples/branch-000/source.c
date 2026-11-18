_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 512u) == 0u)) {
        acc = (acc ^ ((y >> 28u) - y));
        acc = (acc ^ (((y >> 15u) - x) * ((y & x) + (acc * y))));
    } else {
        acc = (acc ^ (((y << 17u) | (x | 3u)) | ((acc | 0u) << 1u)));
    }
    acc = (acc ^ (((x >> 4u) << 13u) | ((x | 7u) & (acc >> 25u))));
    return acc;
}
