package statemonad;

//data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving Show
public abstract  class Tree<T> {

    public abstract void show();
    public abstract boolean isLeaf();

}
