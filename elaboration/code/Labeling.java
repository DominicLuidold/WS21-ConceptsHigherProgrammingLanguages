package statemonad;

public class Labeling {

    public static void main(String[] args) {

        //Solution 12 from Execises: tree = Node (Node (Leaf 'c') 'b' (Node (Leaf 'e') 'd' (Leaf 'f'))) 'a' (Leaf 'g')
        var t = new Node<>(new Node<>(new Leaf<>('c'), 'b', (new Node<>(new Leaf<>('e'), 'd', new Leaf<>('f')))), 'a', (new Leaf<>('g')));

        t.show();

        var treeMonad = labelTree(t);

        var result = treeMonad.StatetoTuple(new Integer(0)).getContent();
        System.out.println("Labled");
        result.show();
    }

    //labelTree :: Tree a -> Tree (a, Int)
    private static StateMonad<Integer, Tree<StateTuple<Integer, Character>>> labelTree(Tree<Character> t) {

        StateMonad<Integer, Integer> updateState = new StateMonad<>(n -> new StateTuple<>(n + 1, n));
        // Pattern Matching would be great here
        if (t.isLeaf()) {
            var leaf = (Leaf<Character>) t;
            return updateState.liftM((Integer state) -> new StateMonad<>(( Integer s) -> new StateTuple<>(s,new Leaf<>(new StateTuple<>(state,leaf.getData())))));

        } else {
            var node = (Node<Character>) t;
            var oldLeft = node.getLeftchild();
            var oldRight = node.getRightchild();
            return labelTree(oldLeft)
                            .liftM((Tree<StateTuple<Integer, Character>> leftLabledSubtree) -> labelTree(oldRight)
                                    .liftM((Tree<StateTuple<Integer, Character>> rightLabledSubtree) -> new StateMonad<>(
                                            (Integer state) -> new StateTuple<>(
                                                    state,
                                                    new Node<>(leftLabledSubtree, new StateTuple<>(state, node.getData()), rightLabledSubtree)))));

        }

    }

    private static boolean isLeaf(Leaf<String> t) {
        return true;
    }


}