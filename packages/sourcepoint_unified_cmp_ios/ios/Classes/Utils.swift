

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

    func complete(result: T) {
        DispatchQueue.main.async {
            self.completionHandler?(result)
        }
    }

    func setCompletionHandler(_ handler: @escaping CompletionHandler) {
        completionHandler = handler
    }
}
