/*:


&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
# Allow implicit self for weak self captures, after self is unwrapped

[SE-0365](https://github.com/apple/swift-evolution/blob/main/proposals/0365-implicit-self-weak-capture.md) takes another step  towards letting us remove `self` from closures by allowing an implicit `self` in places where a `weak self` capture has been unwrapped.

For example, in the code below we have a closure that captures `self` weakly, but then unwraps `self` immediately:
*/
import class Foundation.Timer

class TimerController {
    var timer: Timer?
    var fireCount = 0
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            print("Timer has fired \(fireCount) times")
            fireCount += 1
        }
    }
}
/*:
That code would not have compiled before Swift 5.8, because both instances of `fireCount` in the closure would need to be written `self.fireCount`.

&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
*/
