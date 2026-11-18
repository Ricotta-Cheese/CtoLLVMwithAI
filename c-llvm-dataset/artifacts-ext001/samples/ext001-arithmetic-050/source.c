_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc + (((y * 31u) * (y - y)) - ((y + y) + 16u)));
    acc = (acc - (((1u + 31u) * 0u) * ((3945988754u * y) - (15u * acc))));
    return acc;
}
