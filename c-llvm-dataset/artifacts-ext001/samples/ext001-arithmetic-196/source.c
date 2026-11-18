_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - ((y + (y - acc)) * ((x * 2u) * (31u + y))));
    acc = (acc + ((15u + 2560822700u) - (1u + y)));
    return acc;
}
