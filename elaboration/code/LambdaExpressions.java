import java.util.List;
import java.util.stream.Collectors;

public class LambdaExpressions {
    public static List<Integer> listLambdas(List<Integer> list) {
        return list.stream()
                .map(x -> ++x)
                .collect(Collectors.toList());
    }
}
