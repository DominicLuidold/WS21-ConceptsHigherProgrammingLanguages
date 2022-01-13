package statemonad;

public class Leaf<T> extends Tree<T> {
    private T data;

    public Leaf(T data) {
        this.data = data;
    }

    @Override
    public void show() {
        System.out.print("Leaf( "+data.toString()+" )");
        }

    @Override
    public boolean isLeaf() {
        return true;
    }

    public T getData() {
        return data;
    }
}
