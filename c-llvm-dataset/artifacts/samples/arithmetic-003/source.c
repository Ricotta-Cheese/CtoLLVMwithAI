_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc * acc);
    acc = (acc * (((acc * y) - 3u) - ((x + 1u) + (x * 1u))));
    acc = (acc * ((2u - acc) + 2293464623u));
    acc = (acc + (613564369u * acc));
    return acc;
}
