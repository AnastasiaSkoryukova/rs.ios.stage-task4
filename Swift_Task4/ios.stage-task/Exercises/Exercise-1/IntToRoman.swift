import Foundation

public extension Int {
    
    var roman: String? {
        
        var intValue = self
        
        var result = ""
        
        let mappingList: [(Int, String)] = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        
        
        if intValue < 1 || intValue > 3999{
            return nil
        }
        
        for romanString in mappingList {
            
            while intValue >= romanString.0 {
                intValue -= romanString.0
                result += romanString.1
            }
        }
        
        return result
    }
}



