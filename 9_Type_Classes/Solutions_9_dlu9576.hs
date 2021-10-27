-- 9.14.1 - Natural Numbers 'Ord' and 'Enum'
data Nat = Zero | Succ Nat

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

instance Eq Nat where
    Zero == Zero = True
    Zero == (Succ _) = False
    (Succ _) == Zero = False
    (Succ a) == (Succ b) = a == b

instance Ord Nat where
    Zero <= Zero = True
    Zero <= (Succ _) = True
    (Succ _) <= Zero = False
    (Succ a) <= (Succ b) = a <= b

-- TODO: Solution without int2nat/nat2int
instance Enum Nat where
    toEnum 0 = Zero
    toEnum x = int2nat x
    fromEnum Zero = 0
    fromEnum x = nat2int x
