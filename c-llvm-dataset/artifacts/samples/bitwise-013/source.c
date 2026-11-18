_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x & y);
    acc = (acc ^ (acc ^ x));
    acc = (acc ^ 16u);
    acc = (acc ^ (((y ^ 16u) ^ (acc << 16u)) & ((x << 29u) | 3u)));
    acc = (acc ^ (((x ^ 2775456195u) ^ (x & 31u)) | ((2u << 5u) | (x & y))));
    return acc;
}
