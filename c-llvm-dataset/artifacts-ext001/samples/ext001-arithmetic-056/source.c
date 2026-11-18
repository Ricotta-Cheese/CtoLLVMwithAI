_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + (1895489962u - acc));
    acc = (acc - (((y + x) * (acc - 31u)) - ((y * x) + (y + acc))));
    acc = (acc * (y * (x + y)));
    acc = (acc + (((3u + acc) + (acc * y)) - ((x - y) - (x - 7u))));
    return acc;
}
