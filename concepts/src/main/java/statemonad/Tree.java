package statemonad;

public class Tree<T> {
    private final Node<T> root;

    public Tree(T rootData) {
        this.root = new Node<>();
        this.root.data = rootData;
    }

    public static class Node<T> {
        private T data;
        private Node<T> leftChild;
        private Node<T> rightChild;

        public void show(int level) {
            for (int i = 0; i < level * 2; i++) {
                System.out.print(" ");
            }

            System.out.println("Node: ");
            leftChild.show(level + 1);
            rightChild.show(level + 1);
        }

        @Override
        public String toString() {
            return "{" + leftChild.toString() + "|" + rightChild.toString() + "}";
        }
    }
}