package statemonad;

import java.util.function.Function;

/**
 * @see <a href="https://faustinelli.wordpress.com/2014/04/25/the-state-monad-in-java-8-eventually/">Source: Marco Faustinelli</a>
 */
public class StateMonad<S, A> {
    public final Function<S, StateTuple<A, S>> runState;

    public StateMonad(Function<S, StateTuple<A, S>> runState) {
        this.runState = runState;
    }
}
