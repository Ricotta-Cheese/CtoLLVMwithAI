_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - (acc + ((7u - x) * (y - x))));
    acc = (acc - ((x - 3u) * (acc + y)));
    acc = (acc * (((3522838810u * x) + (y * x)) - ((4294967295u * acc) + (acc * y))));
    acc = (acc + ((y + x) + (y - x)));
    return acc;
}
