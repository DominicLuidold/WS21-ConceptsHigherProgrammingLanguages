import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Scanner;
import java.util.stream.Stream;

public class SideEffects {
    public static int State=0;

    public static void main(String[] args) {
        Impure();

        System.out.println(SideEffects.State);
        var s = new SideEffects();
        s.Pure(10);
        System.out.println(SideEffects.State);

    }

    private static void Impure(){
        System.out.println("Enter string ");

        // Using Scanner for Getting Input from User
        Scanner in = new Scanner(System.in);

        String s = in.nextLine();
        System.out.println("You entered string " + s);

    }

    private void Pure(int x){
        State = x;

    }
}
