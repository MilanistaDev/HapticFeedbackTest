# HapticFeedBackTest

## About this code

This is a sample project for **Haptic feedback** function of iOS.
I wrote article and submitted to Qiita in Japanese.
Please check. (Only in Japanese 🙇‍)
https://qiita.com/MilanistaDev/items/9eb407b923096a1de8f5

There is an input form on the screen, and input restriction is 1 to 10 characters.
When it becomes 8 characters, the device returns feedback of "Warning" to the user.
Return "Failure" feedback when it is 10 characters or 12 characters.
If you tap the send button with 1 to 10 characters entered, "Success" feedback is returned on success.
On the other hand, if it fails, it will return "Failure" feedback.

## Environment

* macOS 10.13.6
* iOS 10 and Later
* iPhone 7 and Later (need Haptic Engine)
* Xcode 10

This code uses `UIImpactFeedbackGenerator`.

https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator

## GIF

Haptic feedback can not be experienced with this GIF animation, so please check with your iOS device.

![hapticfeedback.gif](https://qiita-image-store.s3.amazonaws.com/0/88266/2c4acd40-cc89-7691-e20c-093c573c5121.gif "hapticfeedback.gif")
