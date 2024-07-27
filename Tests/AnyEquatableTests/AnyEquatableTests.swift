import XCTest
@testable import AnyEquatable

final class AnyEquatableTests: XCTestCase {
    
    func test_single_type_equal() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(1)
        XCTAssertTrue(value1 == value2)
        XCTAssertTrue(value2 == value1)
    }
    
    func test_single_type_not_equal() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(2)
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
    }
    
    func test_unmatched_type_not_equal() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(1.0)
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
    }
    
    func test_parameter_packs_equal() {
        let value1 = AnyEquatable(1, true, "string1")
        let value2 = AnyEquatable(1, true, "string1")
        XCTAssertTrue(value1 == value2)
        XCTAssertTrue(value2 == value1)
    }
    
    func test_parameter_packs_not_equal() {
        let value1 = AnyEquatable(1, true, "string1")
        let value2 = AnyEquatable(1, false, "string2")
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
    }
    
    func test_parameter_packs_unmatched_type_and_argument_count_not_equal() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(true, "string")
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
    }
    
    func test_base_and_AnyEquatable_equal() {
        let value1 = 1
        let value2 = AnyEquatable(1)
        XCTAssertTrue(value1 == value2)
        XCTAssertTrue(value2 == value1)
        
        let value3 = AnyEquatable(1)
        let value4 = 1
        XCTAssertTrue(value3 == value4)
        XCTAssertTrue(value4 == value3)
    }
    
    func test_base_and_AnyEquatable_not_equal() {
        let value1 = 1
        let value2 = AnyEquatable(2)
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
        
        let value3 = AnyEquatable(2)
        let value4 = 1
        XCTAssertTrue(value3 != value4)
        XCTAssertTrue(value4 != value3)
    }
    
    func test_any_Equatable_and_AnyEquatable_equal() {
        let value1: any Equatable = 1
        let value2 = AnyEquatable(1)
        XCTAssertTrue(value1 == value2)
        XCTAssertTrue(value2 == value1)
    }
    
    func test_any_Equatable_and_AnyEquatable_not_equal() {
        let value1: any Equatable = 1
        let value2 = AnyEquatable(2)
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
    }
    
    func test_nest_AnyEquatable() {
        let value1 = AnyEquatable(AnyEquatable(1))
        let value2 = AnyEquatable(1)
        XCTAssertTrue(value1 == value2)
//        let value1 = AnyHashable(AnyHashable(AnyHashable(1)))
//        let value2 = AnyHashable(1)
//        XCTAssertTrue(value1 == value2)
    }
    
//    func test_resolve_nested_type() {
//        let value1 = AnyEquatable(1)
//        let value2 = AnyEquatable(AnyEquatable(2))
//        XCTAssertTrue(type(of: value1.base).self == Int.self)
//        XCTAssertTrue(type(of: value2.base).self == Int.self)
//    }
}
