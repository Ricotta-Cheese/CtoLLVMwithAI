_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x * y);
    acc = (acc - (((0u - 2u) + (acc - 4294967295u)) * ((y * acc) + (0u * 1u))));
    acc = (acc - ((acc - x) - (acc + y)));
    acc = (acc - (y * ((x - 4277959371u) - (y * 31u))));
    return acc;
}
