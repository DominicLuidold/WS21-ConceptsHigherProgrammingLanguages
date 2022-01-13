import java.util.function.Function;
import java.util.function.Predicate;

/**
 * @see <a href="https://functionalprogramming.medium.com/function-composition-in-java-beaf39426f52">Source: Dimitris Papadimitriou on Medium</a>
 */
public class FunctionComposition {
    public static void main(String[] args) {
        Function<Integer, Integer> doubleInt = t -> t * 2;
        Function<Integer, Integer> subtractOne = t -> t - 1;

        var firstSubtractOneThenDouble = doubleInt.compose(subtractOne);
        var firstDoubleThenSubtractOne = doubleInt.andThen(subtractOne);

        System.out.println(firstDoubleThenSubtractOne.apply(2)); // prints 3
        System.out.println(firstSubtractOneThenDouble.apply(2)); // prints 2
    }
}
