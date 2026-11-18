_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - (y * 15u));
    acc = (acc + ((x * (2477892078u - acc)) * ((y + acc) * (acc - acc))));
    return acc;
}
