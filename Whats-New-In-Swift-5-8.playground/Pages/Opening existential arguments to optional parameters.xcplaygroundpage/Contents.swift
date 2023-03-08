/*:


&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
# Opening existential arguments to optional parameters

[SE-0375](https://github.com/apple/swift-evolution/blob/main/proposals/0375-opening-existential-optional.md) extends a Swift 5.7 feature that allowed us to call generic functions using a protocol, fixing a small but annoying inconsistency: Swift 5.7 would not allow this behavior with optionals, whereas Swift 5.8 does.

For example, this code worked great in Swift 5.7, because it uses a non-optional `T` parameter:
*/
func double<T: Numeric>(_ number: T) -> T {
    number * 2
}
    
let first = 1
let second = 2.0
let third: Float = 3
    
let numbers: [any Numeric] = [first, second, third]
    
for number in numbers {
    print(double(number))
}
/*:
In Swift 5.8, that same parameter can now be optional, like this:
*/
func optionalDouble<T: Numeric>(_ number: T?) -> T {
    let numberToDouble = number ?? 0
    return  numberToDouble * 2
}
    
for number in numbers {
    print(optionalDouble(number))
}
/*:
In Swift 5.7 that would have issued the rather baffling error message “Type 'any Numeric' cannot conform to 'Numeric’”, so it’s good to see this inconsistency resolved.

&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
*/