import java.util.Scanner;

public class SideEffects {
    public static int State = 0;

    public static void main(String[] args) {
        impure();

        System.out.println(SideEffects.State);
        SideEffects s = new SideEffects();
        s.pure(10);
        System.out.println(SideEffects.State);
    }

    private static void impure() {
        System.out.println("Enter string");

        Scanner in = new Scanner(System.in);

        String s = in.nextLine();
        System.out.println("You entered string " + s);
    }

    private void pure(int x) {
        State = x;
    }
}
