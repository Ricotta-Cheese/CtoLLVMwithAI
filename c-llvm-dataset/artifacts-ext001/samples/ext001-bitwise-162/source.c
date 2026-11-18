_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x | y);
    acc = (acc ^ (((x << 22u) & (y >> 18u)) | (x | (7u << 28u))));
    acc = (acc ^ (3u >> 4u));
    return acc;
}
