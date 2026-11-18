unsigned int compute(unsigned int x, unsigned int y) {
    unsigned int acc = x;
    for (unsigned int i = 0; i < (y & 15u); ++i) {
        if ((acc ^ i) & 1u) {
            acc = (acc + y) ^ i;
        } else {
            acc = (acc * 3u) - i;
        }
    }
    return acc;
}
