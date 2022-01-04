package statemonade;

import java.util.function.Function;
// Tutorial: https://faustinelli.wordpress.com/2014/04/25/the-state-monad-in-java-8-eventually/
public class StateMonade<S, A> {
    public final Function<S, StateTuple<A, S>> runState;

    public StateMonade(Function<S, StateTuple<A, S>> runState) {
        this.runState = runState;
    }
}
