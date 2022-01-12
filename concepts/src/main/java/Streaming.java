import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class Streaming {
    // Minimal Stream
    private final Stream<String> streamEmpty = Stream.empty();

    public static void main(String[] args) {
        try {
            Path path = Paths.get("C:\\file.txt");
            Stream<String> streamOfStrings = Files.lines(path);
            Stream<String> streamOfStringsWithCharset = Files.lines(path, StandardCharsets.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
