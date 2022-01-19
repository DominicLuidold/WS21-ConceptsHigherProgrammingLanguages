package statemonad;

public class Node<T> extends Tree<T> {
    private final T data;
    private final Tree<T> leftChild;
    private final Tree<T> rightChild;

    public Node(Tree<T> leftChild, T data, Tree<T> rightChild) {
        this.data = data;
        this.leftChild = leftChild;
        this.rightChild = rightChild;
    }

    public void show() {
        System.out.print("Node:( ");
        leftChild.show();
        System.out.print(" )");

        System.out.print(" " + data.toString() + " ");
        rightChild.show();
        System.out.print(" )");
    }

    @Override
    public boolean isLeaf() {
        return false;
    }

    @Override
    public String toString() {
        return "(" + leftChild.toString() + ") Node (" + rightChild.toString() + ")";
    }

    public T getData() {
        return data;
    }

    public Tree<T> getLeftChild() {
        return leftChild;
    }

    public Tree<T> getRightChild() {
        return rightChild;
    }
}