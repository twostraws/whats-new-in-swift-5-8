/*:


&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
# Lift all limitations on variables in result builders

[SE-0373](https://github.com/apple/swift-evolution/blob/main/proposals/0373-vars-without-limits-in-result-builders.md) relaxes some of the restrictions on variables when used inside result builders, allowing us to write code that would previously have been disallowed by the compiler.

For example, in Swift 5.8 we can use lazy variables directly inside result builders, like so:
*/
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            lazy var user = fetchUsername()
            Text("Hello, \(user).")
        }
        .padding()
    }
    
    func fetchUsername() -> String {
        "@twostraws"
    }
}
/*:
That shows the *concept*, but doesn’t provide any benefit because the lazy variable is always used – there’s no difference between using `lazy var` and `let` in that code. To see where it’s actually useful takes a longer code example, like this one:
*/
// The user is an active subscriber, not an active subscriber, or we don't know their status yet.
enum UserState {
    case subscriber, nonsubscriber, unknown
}
    
// Two small pieces of information about the user
struct User {
    var id: UUID
    var username: String
}
    
struct SubscriberView: View {
    @State private var state = UserState.unknown
    
    var body: some View {
        VStack {
            lazy var user = fetchUsername()
    
            switch state {
            case .subscriber:
                Text("Hello, \(user.username). Here's what's new for subscribers…")
            case .nonsubscriber:
                Text("Hello, \(user.username). Here's why you should subscribe…")
                Button("Subscribe now") {
                    startSubscription(for: user)
                }
            case .unknown:
                Text("Sign up today!")
            }
        }
        .padding()
    }
    
    // Example function that would do complex work
    func fetchUsername() -> User {
        User(id: UUID(), username: "Anonymous")
    }
    
    func startSubscription(for user: User) {
        print("Starting subscription…")
    }
}
/*:
This approach solves problems that would appear in the alternatives:

- If we didn’t use `lazy`, then `fetchUsername()` would be called in all three cases of `state`, even when it isn’t used in one.
- If we removed `lazy` and placed the call to `fetchUsername()` *inside* the two cases then we would be duplicating code – not a massive problem with a simple one liner, but you can imagine how this would cause problems in more complex code.
- If we moved `user` out to a computed property, it would be called a second time when the user clicked the "Subscribe now" button.

This change also allows us to use property wrappers and local computed properties inside result builders, although I suspect they will be less useful. For example, this kind of code is now allowed: 
*/
struct CounterView: View {
    var body: some View {
        @AppStorage("counter") var tapCount = 0
    
        Button("Count: \(tapCount)") {
            tapCount += 1
        }
    }
}
/*:
However, although that will cause the underlying `UserDefaults` value to change with each tap, using `@AppStorage` in this way *won’t* cause the `body` property to be reinvoked every time `tapCount` changes – our UI won’t automatically be updated to reflect the change.

&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
*/
