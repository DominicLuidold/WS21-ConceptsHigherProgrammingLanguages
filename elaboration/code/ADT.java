public abstract class ADT {


    private ADT() {
    }

    public static final class Alive extends ADT {
        private Alive() {
        }

        public static final Alive INSTANCE = new Alive();

        public <T> T isAlive(IsAliveChecker<T> visitor) {
            return visitor.isAlive(this);
        }
    }

    public static final class Dead extends ADT {
        public Dead() {
        }

        public <T> T isAlive(IsAliveChecker<T> visitor) {
            return visitor.isAlive(this);
        }
    }

    // The IsAliveChecker Interface ensures that all possible expressions
    // are taken into account, provided that the interface
    // is also used in the implementation of the business logic.

    // The Sealed Classs pattern uses an abstract class
    // with a private constructor so that concrete classes
    // can only be created as inner classes within the ADT.
    public interface IsAliveChecker<T> {
        T isAlive(Alive m);

        T isAlive(Dead l);
    }

    public abstract <T> T isAlive(IsAliveChecker<T> visitor);

    public static void main(String[] args) {
        var state = new Dead();
        var bool = state.isAlive(new IsAliveChecker<Boolean>() {

            public Boolean isAlive(ADT.Alive a) {
                return true;
            }
            public Boolean isAlive(ADT.Dead a) {
                return false;
            }
        });
        // By using IsAliveChecker here and not if-instanceOf-else,
        // we can be sure at compile time that all possible cases have been considered.
        System.out.println(bool);

    }

}



