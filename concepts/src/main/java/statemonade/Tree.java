package statemonade;

import java.util.ArrayList;
import java.util.List;

public class Tree<T> {
    private Node<T> root;

    public Tree(T rootData) {
        root = new Node<>();
        root.data = rootData;
    }

    public class Node<T> {
        private T data;
        private Node<T> leftchild;
        private Node<T> rightchild;

        public void show(int level) {
            for (int i = 0; i < level * 2; i++) {
                System.out.print(" ");
            }
            System.out.println("Node: ");
            leftchild.show(level + 1);
            rightchild.show(level + 1);
        }

        @Override
        public String toString() {
            return "{" + leftchild.toString() + "|" + rightchild.toString() + "}";
        }
    }


}