_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x + y);
    acc = (acc - x);
    acc = (acc + ((x * (31u - 16u)) - (0u * (1447935785u * acc))));
    acc = (acc * (1u * acc));
    acc = (acc + ((acc * 16u) - (16u - x)));
    return acc;
}
