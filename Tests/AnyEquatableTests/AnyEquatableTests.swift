import XCTest
import AnyEquatable

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
    
    func test_parameter_packs_unmatched_type_not_equal() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(1.0)
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
    }
    
    func test_parameter_packs_unmatched_type_and_argument_not_equal() {
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
    
    func test_nested_AnyEquatable_equal() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(AnyEquatable(1))
        XCTAssertTrue(value1 == value2)
        XCTAssertTrue(value2 == value1)
    }
    
    func test_nested_AnyEquatable_note_equal() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(AnyEquatable(2))
        XCTAssertTrue(value1 != value2)
        XCTAssertTrue(value2 != value1)
    }
    
    func test_nested_type_resolve_to_base() {
        let value1 = AnyEquatable(1)
        let value2 = AnyEquatable(AnyEquatable(2))
        let value3 = AnyEquatable(AnyEquatable(AnyEquatable(3)))
        let value4 = AnyEquatable(AnyEquatable(AnyEquatable(AnyEquatable(4))))
        XCTAssertTrue(value1.base is Int)
        XCTAssertTrue(value2.base is Int)
        XCTAssertTrue(value3.base is Int)
        XCTAssertTrue(value4.base is Int)
    }
}
