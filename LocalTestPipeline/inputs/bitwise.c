unsigned int compute(unsigned int x, unsigned int y) {
    unsigned int acc = x ^ y;
    return (acc << 3u) | (y >> 2u);
}
