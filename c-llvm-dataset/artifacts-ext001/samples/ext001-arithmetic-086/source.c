_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc * ((acc * (y + x)) + ((y - x) * (2382999417u + 15u))));
    acc = (acc + (y - 3u));
    acc = (acc + (((y - y) * (x - 0u)) + ((31u - acc) - (y + x))));
    return acc;
}
