import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let style = Style.light

    struct Style {
        let backgroundColor: UIColor

        static let light = Style(
            backgroundColor: Color.light.background
        )
    }

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.backgroundColor = style.backgroundColor
        self.window?.makeKeyAndVisible()

        return true
    }
}
