/*:


&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
# Function back deployment

[SE-0376](https://github.com/apple/swift-evolution/blob/main/proposals/0376-function-back-deployment.md) adds a new `@backDeployed` attribute that makes it possible to allow new APIs to be used on older versions of frameworks. It works by writing the code for a function into your app’s binary then performing a runtime check: if your user is on a suitably new version of the operating system then the system’s own version of the function will be used, otherwise the version copied into your app’s binary will be used instead.

On the surface this sounds like a fantastic way for Apple to make some new features retroactively available in earlier operating systems, but I don’t think it’s some kind of silver bullet – `@backDeployed` applies only to functions, methods, subscripts, and computed properties, so while it might work great for smaller API changes such as the `fontDesign()` modifier introduced in iOS 16.1, it wouldn’t work for any code that requires new types to be used, such as the new `scrollBounceBehavior()` modifier that relies on a new `ScrollBounceBehavior` struct.

As an example, iOS 16.4 introduced a `monospaced(_ isActive:)` variant for `Text`. If this were using `@backDeployed`, the SwiftUI team might ensure the modifier is available to whatever earliest version of SwiftUI supports the implementation code they actually need, like this:
*/
import SwiftUI

extension Text {
    @backDeployed(before: iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4)
    @available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
    public func monospaced(_ isActive: Bool) -> Text {
        fatalError("Implementation here")
    }
}
/*:
At runtime, Swift will use the system’s copy of SwiftUI if it has that modifier already, otherwise using the back-deployed version back to iOS 14.0 and similar.

&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
*/
