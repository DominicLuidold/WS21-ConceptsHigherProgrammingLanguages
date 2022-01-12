public class ImmutableIntegerPair {
    private final int x;
    private final int y;

    ImmutableIntegerPair(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }
}
