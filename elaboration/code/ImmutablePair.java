//For this class the values x and y can only be set in the constructor
public class ImmutablePair {

        private final int x;
        private final int y;

    public ImmutablePair(int x, int y) {
            this.x = x;
            this.y = y;
        }

    public int getY() {
        return y;
    }

    public int getX() {
        return x;
    }
}
