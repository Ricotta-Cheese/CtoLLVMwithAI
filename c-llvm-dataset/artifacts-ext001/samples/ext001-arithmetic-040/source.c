_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc + ((x - (y + 31u)) * (acc + (y + acc))));
    acc = (acc + (((acc + y) * (y - x)) * ((3u - 16u) * (x + y))));
    acc = (acc + ((y + y) - (16u + y)));
    acc = (acc * (y + acc));
    return acc;
}
