import UIKit

//let str = "1,00"
//if let d = Double(String(str.split(separator: ",").joined(separator:["."]))) {
//    print(d)
//    if d > 0 {
//        print("Greater Than 1")
//    }
//} else {
//    print("Nil")
//}

//
//var array = "0,09"
//var sarray = array.split(separator: ",").joined(separator:["."])
//print(sarray)

//let stringArray = ["Bob", "Dan", "Bryan"]
//let string = stringArray.joined(separator: "-")
//print(string)
//extension String {
//    var preparedToDecimalNumberConversion: String {
//        split {
//            !CharacterSet(charactersIn: "\($0)").isSubset(of: CharacterSet.decimalDigits)
//        }.joined(separator: ".")
//    }
//
//    var doubleValue: Double {
//        Double(self.preparedToDecimalNumberConversion) ?? 0
//    }
//}

//print("1,00".preparedToDecimalNumberConversion)
//print(Double("_".preparedToDecimalNumberConversion))
//print(" @1222,00".doubleValue)

func doubleValue(value: String?) -> Double {
    Double(value?.split {
        !CharacterSet(charactersIn: "\($0)").isSubset(of: CharacterSet.decimalDigits)
    }.joined(separator: ".") ?? "") ?? 0
}
var value = doubleValue(value: "1,004245345325")
print(value)
print(String(format: "Fee Info: %.2f", value))
