package statemonad;

import java.util.function.Function;

/**
 * https://faustinelli.wordpress.com/2014/04/25/the-state-monad-in-java-8-eventually/ Source: Marco Faustinelli 
 */
public class StateMonad<S, A> {
    public final Function<S, StateTuple<A, S>> runState;

    public StateMonad(Function<S, StateTuple<A, S>> runState) {
        this.runState = runState;
    }

    public StateTuple<S, A> StatetoTuple(S state) {
		return this.runState.apply(state);
	}

	/**
	 * UNIT
	 */
	public static <S, A> StateMonad<S, A> UNIT(A a) {

		return new StateMonad<S, A>((S s) -> new StateTuple<S, A>(s, a));
	}

    /**
	 * Promote a function to a monad. 
	 * 
	 * In Haskell:
	 * 
	 * liftM f m = m >>= \x -> return (f x)
	 */
	public <B> StateMonad<S, B> liftM(final Function<A, StateMonad<S, B>> func) {

		return new StateMonad<S, B>((S s) -> {

			StateTuple<S, A> content = this.runState(s);

			StateMonad<S, B> out = func.apply(content.content);

			return out.runState(content.state);
		});
	}
}
