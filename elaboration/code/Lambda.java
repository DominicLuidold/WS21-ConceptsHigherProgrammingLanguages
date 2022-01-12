import java.util.List;
import java.util.stream.Collectors;

public class Lambda {
    public static List<Integer> listLambdas(List<Integer> list) {
        // Lambdas
        return list.stream()
                .map(x-> ++x)
                .collect(Collectors.toList());
    }
}
