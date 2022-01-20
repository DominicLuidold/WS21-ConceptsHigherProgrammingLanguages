package statemonad;

public class Labelling {

    public static void main(String[] args) {
        // Solution from Exercise 12:
        // tree = Node (Node (Leaf 'c') 'b' (Node (Leaf 'e') 'd' (Leaf 'f'))) 'a' (Leaf 'g')
        Node<Character> tree = new Node<>(new Node<>(new Leaf<>('c'), 'b', new Node<>(new Leaf<>('e'), 'd', new Leaf<>('f'))), 'a', new Leaf<>('g'));
        tree.show();

        StateMonad<Integer, Tree<StateTuple<Integer, Character>>> treeMonad = labelTree(tree);
        Tree<StateTuple<Integer, Character>> result = treeMonad.StatetoTuple(0).getContent();

        System.out.println("Labled");
        result.show();
    }

    // labelTree :: Tree a -> Tree (a, Int)
    private static StateMonad<Integer, Tree<StateTuple<Integer, Character>>> labelTree(Tree<Character> t) {
        StateMonad<Integer, Integer> updateState = new StateMonad<>(n -> new StateTuple<>(n + 1, n));

        // Pattern Matching would be great here..
        if (t.isLeaf()) {
            Leaf<Character> leaf = (Leaf<Character>) t;

            return updateState.bind((Integer state) -> new StateMonad<>((Integer s) -> new StateTuple<>(s, new Leaf<>(new StateTuple<>(state, leaf.getData())))));
        } else {
            Node<Character> node = (Node<Character>) t;
            Tree<Character> oldLeft = node.getLeftChild();
            Tree<Character> oldRight = node.getRightChild();

            return labelTree(oldLeft)
                    .bind((Tree<StateTuple<Integer, Character>> leftLabeledSubtree) -> labelTree(oldRight)
                            .bind((Tree<StateTuple<Integer, Character>> rightLabeledSubtree) -> new StateMonad<>(
                                    (Integer state) -> new StateTuple<>(state, new Node<>(leftLabeledSubtree, new StateTuple<>(state, node.getData()), rightLabeledSubtree)))));
        }
    }
}
