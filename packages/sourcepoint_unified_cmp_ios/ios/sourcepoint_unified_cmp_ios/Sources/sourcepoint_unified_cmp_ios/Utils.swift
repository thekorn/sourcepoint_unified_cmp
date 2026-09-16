
import UIKit

func getTopMostViewController() -> UIViewController? {
  var topMostViewController = UIApplication.shared.keyWindow?.rootViewController

  while let presentedViewController = topMostViewController?.presentedViewController {
    topMostViewController = presentedViewController
  }

  return topMostViewController
}

class Completer<T> {
  typealias CompletionHandler = (T) -> Void

  private var completionHandler: CompletionHandler?
  private var isCompleted = false

  /// The handler runs at most once per `setCompletionHandler`, so a second
  /// caller reaching `complete` after the first one does not hand the same
  /// pigeon reply back twice.
  func complete(result: T) {
    DispatchQueue.main.async {
      guard !self.isCompleted else { return }
      self.isCompleted = true
      self.completionHandler?(result)
    }
  }

  func setCompletionHandler(_ handler: @escaping CompletionHandler) {
    completionHandler = handler
    isCompleted = false
  }
}
