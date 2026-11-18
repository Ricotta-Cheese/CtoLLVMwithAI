_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    if ((((x ^ y) & 131072u) == 0u)) {
        acc = (acc ^ (y >> 29u));
    } else {
        acc = (acc ^ (((acc * 31u) * (y * acc)) | (y - (acc ^ x))));
        acc = (acc ^ ((y ^ acc) << 10u));
    }
    acc = (acc ^ (y | acc));
    return acc;
}
