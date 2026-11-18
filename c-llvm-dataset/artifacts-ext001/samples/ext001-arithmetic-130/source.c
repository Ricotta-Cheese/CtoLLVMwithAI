_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + (2u * y));
    acc = (acc * ((x + 0u) - (2365954077u + x)));
    acc = (acc + ((y - 0u) * x));
    acc = (acc * (((y * y) * y) * ((15u - x) * (acc + 3u))));
    return acc;
}
