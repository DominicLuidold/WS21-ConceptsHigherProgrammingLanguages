-- 8.7.4 - Lazy Fibonacci
-- Improved by https://stackoverflow.com/a/50062271
lazyFibonacci :: [Integer]
lazyFibonacci = lazyFibonacci' 0 1 where
    lazyFibonacci' x y = x : lazyFibonacci' y (x + y)
