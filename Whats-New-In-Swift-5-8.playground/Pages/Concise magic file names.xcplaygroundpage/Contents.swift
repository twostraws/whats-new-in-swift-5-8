/*:


&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
# Concise magic file names

[SE-0274](https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md) adjusts the `#file` magic identifier to use the format Module/Filename, e.g. MyApp/ContentView.swift. Previously, `#file` contained the whole path to the Swift file, e.g. `/Users/twostraws/Desktop/WhatsNewInSwift/WhatsNewInSwift/ContentView.swift`, which is unnecessarily long and also likely to contain things you’d rather not reveal.

**Important:** Right now this behavior is not enabled by default. [SE-0362](https://github.com/apple/swift-evolution/blob/main/proposals/0362-piecemeal-future-features.md) adds a new `-enable-upcoming-feature` compiler flag designed to let developers opt into new features before they are fully enabled in the language, so to enable the new `#file` behavior you should add `-enable-upcoming-feature ConciseMagicFile` to Other Swift Flags in Xcode.

If you’d like to have the old behavior after this flag is enabled, you should use `#filePath` instead:
*/
// New behavior, when enabled
print(#file)
    
// Old behavior, when needed
print(#filePath)
/*:
The [Swift Evolution proposal for this change](https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md) is worth reading because it mentions surprisingly large improvements in binary size and execution performance, and also for this quite brilliant paragraph explaining why having the full path is often a bad idea:

> “The full path to a source file may contain a developer's username, hints about the configuration of a build farm, proprietary versions or identifiers, or the Sailor Scout you named an external disk after.”

&nbsp;

[< Previous](@previous)           [Home](Introduction)           [Next >](@next)
*/