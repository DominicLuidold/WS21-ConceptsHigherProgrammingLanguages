import java.util.function.Function;

// https://functionalprogramming.medium.com/function-composition-in-java-beaf39426f52
// Funktionale Komposition bezieht sich auf eine Technik, bei der mehrere Funktionen zu einer einzigen Funktion kombiniert werden. Wir können Lambda-Ausdrücke miteinander kombinieren. Java bietet eine eingebaute Unterstützung durch die Klassen Predicate und Function. Das folgende Beispiel zeigt, wie man zwei Funktionen mit Hilfe des Predicate-Ansatzes kombinieren kann.
public class FunctionComposition {
    public static void main(String[] args) {
    Function<Integer, Integer> doubleing = t -> t * 2;
    Function<Integer, Integer> remove1 = t -> t  - 1;
    var FirstRemove1ThenDouble = doubleing.compose(remove1);
    var FirstDoubleThenRemove1 = doubleing.andThen(remove1);
    System.out.println(FirstDoubleThenRemove1.apply(2));
    System.out.println(FirstRemove1ThenDouble.apply(2));
    }
}
