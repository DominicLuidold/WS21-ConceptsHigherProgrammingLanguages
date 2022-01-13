public class Labeling {

	public static void main(String[] args) {

		System.out.println("unlabeled tree");

        //		Tree<String> t = new Node<String>("a"); 

		Tree<String> t = new Node<String>(new Node<String>("a"), new Node<String>(
				new Node<String>(new Node<String>("b"), new Node<String>("c")),
				new Node<String>("d")));

		t.show(2);

		StateMonad<Integer, Tree<StateTuple<Integer, String>>> treeMonad = MkM(t);
		
		Tree<StateTuple<Integer, String>> result = treeMonad.runState(new Integer(0)).content;

		result.show(2);
	}

	private static StateMonad<Integer, Tree<StateTuple<Integer, String>>> MkM(Tree<String> t) {

		/**
		 * n -> (n+1,n) : Integer -> (Integer,Integer)
		 * It may be bound to famb :
		 * Integer -> StateMonad<Integer,B>
		 */
		StateMonad<Integer, Integer> updateState = new StateMonad<Integer, Integer>(
				n -> new StateTuple<Integer, Integer>(n + 1, n));

		if (t instanceof Node<?>) {

			Node<String> leaf = (Node<String>) t;
			
			return

			updateState.bind((Integer state) -> new StateMonad<Integer, Tree<StateTuple<Integer, String>>>((
						Integer s) -> new StateTuple<Integer, Tree<StateTuple<Integer, String>>>(s,
							new Node<StateTuple<Integer, String>>(
									new StateTuple<Integer, String>(state,
											leaf.contents)))));

		} else if (t instanceof Node<?>) {
			/**
			 * do
			 *  leftDLB <- MkM(t.left)
			 *  rightDLB <- MkM(t.right) 
			 * return (Node leftDLB rightDLB)
			 */
			Node<String> br = (Node<String>) t;
			Tree<String> oldLeft = br.left;
			Tree<String> oldRight = br.right;
			
			return

			MkM(oldLeft)
					.bind((Tree<StateTuple<Integer, String>> leftDLB) -> MkM(oldRight)
							.bind((Tree<StateTuple<Integer, String>> rightDLB) -> new StateMonad<Integer, Tree<StateTuple<Integer, String>>>(
										(Integer s) -> new StateTuple<Integer, Tree<StateTuple<Integer, String>>>(
													s,
													new Node<StateTuple<Integer, String>>(
															leftDLB, rightDLB)))));

		} else {
			throw new RuntimeException("Lab/Label: impossible tree subtype");
		}
	}
}