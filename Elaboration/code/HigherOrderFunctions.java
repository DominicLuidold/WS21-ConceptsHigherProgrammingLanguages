import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

// Source:
// https://medium.com/@knoldus/functional-java-lets-understand-the-higher-order-function-1a4d4e4f02af
// https://stackoverflow.com/questions/15198979/lambda-expressions-and-higher-order-functions
public class HigherOrderFunctions {
    public static void main(String[] args) {
        Function<Integer, Long> addOne = add(1L);

        System.out.println(addOne.apply(1)); //prints 2

        Arrays.asList("test", "new")
                .parallelStream()  // suggestion for execution strategy
                .map(camelize)     // call for static reference
                .forEach(System.out::println);
    }

    private static Function<Integer, Long> add(long l) {
        return (Integer i) -> l + i;
    }

    private static Function<String, String> camelize = (str) ->
            str.substring(0, 1).toUpperCase() + str.substring(1);

}
