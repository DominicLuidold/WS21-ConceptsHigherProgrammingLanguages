package statemonad;

import java.util.function.Function;

/**
 * <a>https://faustinelli.wordpress.com/2014/04/25/the-state-monad-in-java-8-eventually/</a> Source: Marco Faustinelli
 */
public class StateMonad<S, C> {
    public final Function<S, StateTuple<S, C>> runState;

    public StateMonad(Function<S, StateTuple<S, C>> runState) {
        this.runState = runState;
    }

    public StateTuple<S, C> StatetoTuple(S state) {
        return this.runState.apply(state);
    }

    /**
     * UNIT
     */
    public static <S, C> StateMonad<S, C> UNIT(C a) {
        return new StateMonad<S, C>((S s) -> new StateTuple<S, C>(s, a));
    }

    /**
     * Promote a function to a Monad.
     * <p>
     * In Haskell:
     * liftM f m = m >>= \x -> return (f x)
     */
    public <B> StateMonad<S, B> liftM(final Function<C, StateMonad<S, B>> func) {
        return new StateMonad<S, B>((S s) -> {
            StateTuple<S, C> content = this.StatetoTuple(s);
            StateMonad<S, B> out = func.apply(content.getContent());

            return out.StatetoTuple(content.getState());
        });
    }
}
