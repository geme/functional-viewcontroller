//
//  Router.swift
//  routing
//
//  Created by Gerrit Menzel on 14.06.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

protocol Output {}

enum Error: ErrorProtocol {
    case error
}

class Router {

    typealias OutputPromise = Promise<(UINavigationController, Output), ErrorProtocol>

    static func dashboard(nav: UINavigationController) -> Promise<(UINavigationController, DashboardOutput), ErrorProtocol> {
        return Promise { c in
            let vc = DashboardViewController()
            vc.onCompletion = { (dashboardOutput: DashboardOutput) in
                c(Result((nav, dashboardOutput)))
            }
            nav.pushViewController(vc, animated: true)
        }
    }

    static func red(_ nav: UINavigationController, _ text: String) -> OutputPromise {
        return Promise { c in
            let vc = RedViewController()
            vc.onCompletion = { (redOutput: RedOutput) in
                c(Result(nav, redOutput as Output))
            }
            nav.pushViewController(vc, animated: true)
        }
    }

    static func blue(_ nav: UINavigationController, _ num: Int) -> OutputPromise {
        return Promise { c in
            let vc = BlueViewController()
            vc.onCompletion = { (blueOutput: BlueOutput) in
                c(Result(nav, blueOutput as Output))
            }
            nav.pushViewController(vc, animated: true)
        }
    }

    static func dashboardOutput(_ red: (UINavigationController, String) -> OutputPromise, _ blue: (UINavigationController, Int) -> OutputPromise) -> (UINavigationController, DashboardOutput) -> OutputPromise {
        return { nav, dashboardOutput in
            switch dashboardOutput {
            case let .red(text): return red(nav, text)
            case let .blue(num): return blue(nav, num)
            default: break
            }
            return Promise {
                $0(Result(Error.error))
            }
        }
    }


    class func app() -> UIViewController {

        let navigationController = UINavigationController(rootViewController: UIViewController())

        let _ = dashboard(nav: navigationController).then(dashboardOutput(
            red,
            blue
            )).onCompletion { _ in
            print("done")
        }

//        let _ =
//        DashboardViewController()
//            .red(RedViewController()
//                .gold(GoldViewController())
//                .silver(SilverViewController()
//                    .ruby(RubyViewController())
//                    .saphire(SaphireViewController())
//                    .diamond(DiamondViewController()))
//                .crystal(CrystalViewController()))
//            .blue(BlueViewController())
//            .green(GreenViewController())
//            .yellow(YellowViewController())


        return navigationController
    }

}

class GreenViewController: UIViewController {}
class YellowViewController: UIViewController {}

class GoldViewController: UIViewController {}
class SilverViewController: UIViewController {}
class CrystalViewController: UIViewController {}

class RubyViewController: UIViewController {}
class SaphireViewController: UIViewController {}
class DiamondViewController: UIViewController {}

class PearlViewController: UIViewController {}
class PlatinViewController: UIViewController {}

class BlackViewController: UIViewController {}
class WhiteViewController: UIViewController {}

class XViewController: UIViewController {}
class YViewController: UIViewController {}
