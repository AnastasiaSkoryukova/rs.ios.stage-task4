import Foundation

final class FillWithColor {
    
    var startingPointElement: (Int, Int) = (0,0)
    
    var topElementToCheck: (Int, Int) = (0,0)
    var bottomElementToCheck: (Int, Int) = (0,0)
    var leftElementToCheck: (Int, Int) = (0, 0)
    var rightElementToCheck: (Int, Int) = (0,0)
    
    var locationsArray: [(Int, Int)] = [(0,0)]
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        var result = image
        
        
        if image.count >= 1 && column <= 50 && row >= 0 && column >= 0 && newColor < 65536 && row <= image.count {
            
            let array = image[row]
            let element = array[column]
            self.startingPointElement = (row,column)
            let updatedElement = newColor
            result[row].insert(updatedElement, at: column)
            result[row].remove(at: column + 1)
            
            checkElementsToColor(element: self.startingPointElement)
            
            
            for _ in 0...image.count {
                
                for locationArray in locationsArray {
                    
                    if locationArray.0 <= image.count - 1 &&  locationArray.1 <= image[row].count - 1 && element == result[locationArray.0][locationArray.1] {
                        
                        result[locationArray.0].insert(updatedElement, at: locationArray.1)
                        result[locationArray.0].remove(at: locationArray.1 + 1)
                        checkElementsToColor(element: locationArray)
                    }
                }
            }
        } else {
            return image
        }
        
        return result
    }
    
    
    func checkElementsToColor(element: (Int, Int)) {
        
        let arrayNumber = element.0
        let elementNumber = element.1
        
        
        if arrayNumber > 0 {
            self.topElementToCheck.0 = arrayNumber - 1
            self.topElementToCheck.1 = elementNumber
            self.locationsArray.append(topElementToCheck)
        }
        
        self.bottomElementToCheck.0 = arrayNumber + 1
        self.bottomElementToCheck.1 = elementNumber
        
        if elementNumber > 0 {
            self.leftElementToCheck.1 = elementNumber - 1
            self.leftElementToCheck.0 = arrayNumber
            self.locationsArray.append(leftElementToCheck)
        }
        self.rightElementToCheck.1 = elementNumber + 1
        self.rightElementToCheck.0 = arrayNumber
        
        self.locationsArray.append(bottomElementToCheck)
        
        self.locationsArray.append(rightElementToCheck)
    }
}


