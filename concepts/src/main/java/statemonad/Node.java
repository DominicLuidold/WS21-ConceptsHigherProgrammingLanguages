package statemonad;

public class Node<T> extends Tree<T>{
    private T data;
    private Tree<T> leftchild;
    private Tree<T> rightchild;

    public Node( Tree<T> leftchild,T data, Tree<T> rightchild) {
        this.data = data;
        this.leftchild = leftchild;
        this.rightchild = rightchild;
    }

    public void show() {
        System.out.print("Node:( ");
        leftchild.show();
        System.out.print(" )");

        System.out.print(" "+data.toString()+" ");
        rightchild.show();
        System.out.print(" )");
    }

    @Override
    public boolean isLeaf() {
        return false;
    }

    @Override
    public String toString() {
        return "(" + leftchild.toString() + ") Node (" + rightchild.toString() + ")";
    }

    public Tree<T> getLeftchild(){
        return leftchild;
    }
    public Tree<T> getRightchild(){
        return rightchild;
    }

    public T getData() {
        return data;
    }
}