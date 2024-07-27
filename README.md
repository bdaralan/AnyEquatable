# AnyEquatable

A type-erased equatable value.

## Equatable

``` swift
let value1 = 4
let value2 = AnyEquatable(4)
print(value1 == value2) // true
```

``` swift
let value1 = 4
let value2 = AnyEquatable(9)
print(value1 != value2) // true
```

## Parameter Packs


``` swift
let value1 = AnyEquatable(true, 4, "9")
let value2 = AnyEquatable(true, 4, "9")
print(value1 == value2) // true
```

``` swift
let value1 = AnyEquatable(true, 4, 9)
let value2 = AnyEquatable(true, 4, "9")
print(value1 != value2) // true
```
