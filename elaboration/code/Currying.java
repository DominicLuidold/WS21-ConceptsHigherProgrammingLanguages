import java.util.function.Function;

/**
 * @see <a href="https://www.geeksforgeeks.org/currying-functions-in-java-with-examples/">Source: GeeksForGeeks</a>
 * @see <a href="http://baddotrobot.com/blog/2013/07/21/curried-functions/">Source: Toby Weston on bad.robot</a>
 */
public class Currying {
    public static int multNormal(int a, int b) {
        return a * b;
    }

    public static Function<Integer, Function<Integer, Integer>> multCurry() {
        return x -> y -> x * y;
    }

    public static void main(String[] args) {
        System.out.println(multNormal(1, 5)); // prints 5
        System.out.println(multCurry().apply(1).apply(5)); // prints 5
    }
}
