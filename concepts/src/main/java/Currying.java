import java.util.Arrays;
import java.util.function.Function;
// Example 2 https://www.geeksforgeeks.org/currying-functions-in-java-with-examples/
//Source: http://baddotrobot.com/blog/2013/07/21/curried-functions/
public class Currying {
    public static int multNormal(int a, int b) {
        return a * b;
    }

    public static Function<Integer, Function<Integer, Integer>> multcurry() {
        return x -> y -> x * y;
    }

    public static void main(String[] args) {
        var mult1 = multNormal(1,5); //= 5

        System.out.println(mult1); //prints 5
        System.out.println(multcurry().apply(1).apply(5)); // prints 5

    }
}
