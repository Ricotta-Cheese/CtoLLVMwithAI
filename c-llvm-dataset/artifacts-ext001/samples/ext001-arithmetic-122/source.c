_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");
unsigned int compute(unsigned int x, unsigned int y) {
    (void)x;
    (void)y;
    unsigned int acc = (x - y);
    acc = (acc * (y - x));
    acc = (acc - (y + ((15u - acc) - (3198771028u - acc))));
    acc = (acc * ((y * 4294967295u) + (x - 1u)));
    acc = (acc + (x * ((y + y) + acc)));
    return acc;
}
