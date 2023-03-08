/*:


&nbsp;

[< Previous](@previous)           [Home](Introduction)
# Collection downcasts in cast patterns are now supported

This resolves another small but potentially annoying inconsistency in Swift where downcasting a collection – e.g. casting an array of `ClassA` to an array of another type that *inherits* from `ClassA` – would not be allowed in some circumstances.

For example, this code is now valid in Swift 5.8, whereas it would not have worked previously:
*/
class Pet { }
class Dog: Pet {
    func bark() { print("Woof!") }
}
    
func bark(using pets: [Pet]) {
    switch pets {
    case let pets as [Dog]:
        for pet in pets {
            pet.bark()
        }
    default:
        print("No barking today.")
    }
}
/*:
Before Swift 5.8 that would have led to the error message, “Collection downcast in cast pattern is not implemented; use an explicit downcast to '[Dog]' instead.” In practice, syntax such as `if let dogs = pets as? [Dog] {` worked just fine, so I would imagine that error was rarely seen. However, this change does mean another language inconsistency is resolved, which is always welcome.

&nbsp;

[< Previous](@previous)           [Home](Introduction)
*/