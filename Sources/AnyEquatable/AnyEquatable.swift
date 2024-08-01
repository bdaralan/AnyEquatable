/// A type-erased equatable value.
///
/// The `AnyEquatable` type forwards equality comparisons to an underlying equatable value.
/// 
public struct AnyEquatable: Equatable {
    
    /// The wrapped equatable value.
    public let base: Any
    
    /// The condition in which two values are equal.
    private let equals: (Any, Any) -> Bool
    
    /// Create typed-erased equatable by specifying how two values are equal.
    private init<Value>(base: Value, equals: @escaping (Value, Value) -> Bool) {
        self.base = base
        self.equals = { lhs, rhs in
            guard let lhs = lhs as? Value else { return false }
            guard let rhs = rhs as? Value else { return false }
            return equals(lhs, rhs)
        }
    }
    
    public static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
        lhs.equals(lhs.base, rhs.base)
    }
    
    public static func == (lhs: some Equatable, rhs: AnyEquatable) -> Bool {
        rhs.equals(lhs, rhs.base)
    }
    
    public static func == (lhs: AnyEquatable, rhs: some Equatable) -> Bool {
        lhs.equals(lhs.base, rhs)
    }
    
    public static func != (lhs: some Equatable, rhs: AnyEquatable) -> Bool {
        rhs.equals(lhs, rhs.base) == false
    }
    
    public static func != (lhs: AnyEquatable, rhs: some Equatable) -> Bool {
        lhs.equals(lhs.base, rhs) == false
    }
}

// MARK: - Constructors

extension AnyEquatable {
    
    /// Creates a type-erased equatable value from another `AnyEquatable`.
    ///
    /// ``` swift
    /// let value1 = AnyEquatable(AnyEquatable(4))
    /// let value2 = AnyEquatable(4)
    /// print(value1 == value2) // true
    /// print(value1.base is Int) // true
    /// ```
    public init(_ base: AnyEquatable) {
        switch base.base {
        case let baseBase as AnyEquatable: self = baseBase
        default: self = base
        }
    }
    
    /// Creates a type-erased equatable value that wraps the given parameter packs.
    /// 
    /// ``` swift
    /// let value1 = AnyEquatable(4, true, "string1")
    /// let value2 = AnyEquatable(4, true, "string1")
    /// print(value1 == value2) // true
    /// ```
    public init<each Value>(_ base: repeat each Value) where repeat each Value: Equatable {
        self.init(base: (repeat each base)) { lhs, rhs in
            do {
                // there is a new cleaner for-in syntax but only available in swift 6.0
                repeat try Self.equals(lhs: each lhs, rhs: each rhs)
                return true
            } catch {
                return false
            }
        }
    }
}

// MARK: - Helpers

extension AnyEquatable {
    
    /// An error to throw when two values are not equal.
    ///
    private struct NotEqualError: Error {}
    
    /// A helper method for iterating parameter packs to check for equality and throw to return early.
    ///
    /// For more detail, see [Why Pack Iteration?][documentation] documentation.
    ///
    /// [documentation]: https://www.swift.org/blog/pack-iteration/#why-pack-iteration
    private static func equals<Value>(lhs: Value, rhs: Value) throws where Value: Equatable {
        guard lhs == rhs else { throw NotEqualError() }
    }
}
