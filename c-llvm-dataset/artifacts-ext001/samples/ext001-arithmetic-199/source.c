_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc + (2181492234u + ((y - 4294967295u) * (y * y))));
    acc = (acc - (16u - (x - y)));
    acc = (acc + (x * 3u));
    acc = (acc + (((acc * y) + (y + acc)) + ((7u * acc) * (x * x))));
    return acc;
}
