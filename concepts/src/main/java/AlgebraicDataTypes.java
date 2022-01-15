public abstract class AlgebraicDataTypes {
    private AlgebraicDataTypes() {
    }

    public static final class Alive extends AlgebraicDataTypes {
        private Alive() {
        }

        public <T> T isAlive(IsAliveChecker<T> visitor) {
            return visitor.isAlive(this);
        }
    }

    public static final class Dead extends AlgebraicDataTypes {
        public Dead() {
        }

        public <T> T isAlive(IsAliveChecker<T> visitor) {
            return visitor.isAlive(this);
        }
    }

    // The IsAliveChecker interface ensures that all possible expressions
    // are taken into account, provided that the interface
    // is also used in the implementation of the business logic.

    // The Sealed Class pattern uses an abstract class
    // with a private constructor so that concrete classes
    // can only be created as inner classes within the ADT.
    public interface IsAliveChecker<T> {
        T isAlive(Alive m);

        T isAlive(Dead l);
    }

    public abstract <T> T isAlive(IsAliveChecker<T> visitor);

    public static void main(String[] args) {
        Dead state = new Dead();
        Boolean bool = state.isAlive(new IsAliveChecker<>() {

            public Boolean isAlive(Alive a) {
                return true;
            }

            public Boolean isAlive(Dead a) {
                return false;
            }
        });

        // By using IsAliveChecker here and not if-instanceOf-else,
        // we can be sure at compile time that all possible cases have been considered.
        System.out.println(bool);
    }
}
