import UIKit
class ViewController: UIViewController {
    var y = 0
    var number = 0
    override func viewDidLoad() {
        super.viewDidLoad()

//        fetchX(
//            {x in
//                fetchy(x, {y in
//                    print(x + y)
//            })
//        })

        fetchXplusY { res in
            print(res)
        }


    }

    func fetchX(_ callback: (Int) -> Void) -> Void {
        number = 3
        return callback(number)
    }

    func fetchy(_ x: Int, _ callback: (Int) -> Void) -> Void {
        y = x
        return callback(y)
    }

    func fetchz(_ x: Int, _ y:Int ,_ callback: (Int) -> Void) -> Void {
        return callback(3)
    }


//    func xplusy2(_ callbackx: Int, _ callbacky: Int,_ callbackxplusy: (Int) -> Void) -> Void{
//        return callbackxplusy(callbackx + callbacky)
//    }

    func fetchXplusY( callback: (Int) -> Void) -> Void{
//        fetchX({callbackx in callbackx}) + fetchy({})
        fetchX({x in
            fetchy(x, {y in
                callback(x + y)
            })
        })
    }

    func fetchxyz( callback: (Int) -> Void) -> Void {
        fetchX({x in
            fetchy(x, {y in
                fetchz(x,y, {z in
                    callback(x + y + z)
                })
            })
        })
    }
}


