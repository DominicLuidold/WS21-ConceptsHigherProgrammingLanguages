import java.util.function.Function;

// Source: https://functionalprogramming.medium.com/function-composition-in-java-beaf39426f52
// Functional composition refers to a technique where multiple functions are combined into a single function.
// We can combine lambda expressions together. Java provides built-in support through the Predicate and Function classes.
// The following example shows how to combine two functions using the Predicate approach.
public class FunctionComposition {
    public static void main(String[] args) {
    Function<Integer, Integer> doubleing = t -> t * 2;
    Function<Integer, Integer> remove1 = t -> t  - 1;
    var FirstRemove1ThenDouble = doubleing.compose(remove1);
    var FirstDoubleThenRemove1 = doubleing.andThen(remove1);
    System.out.println(FirstDoubleThenRemove1.apply(2)); // result 3
    System.out.println(FirstRemove1ThenDouble.apply(2)); // result 3
    }
}
