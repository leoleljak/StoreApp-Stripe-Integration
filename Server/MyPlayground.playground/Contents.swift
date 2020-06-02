import UIKit

var str = "Hello, playground"

var items = ["a": 1] as [String: Any]
items["c"] = nil
print(items["c"] as Any)

let numbers = [1,2,3,4,5,6].filter{ $0 % 2 == 0}
print (numbers)

var vals = [10, 2]
vals.sort { (s1, s2) -> Bool in
    s1>s2
}
let s = 20
print(s)
print(s)
let s1 = 20
print(s)


print(vals)
print(vals)

