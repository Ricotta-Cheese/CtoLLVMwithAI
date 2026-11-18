_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + (y - y));
    acc = (acc * ((x + acc) * (x - y)));
    acc = (acc + (((15u + 3u) - (x + 4294967295u)) * (y * (y + x))));
    acc = (acc + x);
    return acc;
}
