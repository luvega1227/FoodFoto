
import UIKit

class FoodStore {
    
    var allFood = [Food]()
    let foodArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("food.archive")
    }()
    
    func createFood() -> Food {
        let newFood = Food(random: true)
        
        allFood.append(newFood)
        
        return newFood
        
    }
    
    func removeFood(_ food: Food) {
        if let index = allFood.index(of: food) {
            allFood.remove(at: index)
        }
    }
    
    func moveFoodAtIndex(_ fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedFood = allFood[fromIndex]
        
        // Remove food from array
        allFood.remove(at: fromIndex)
        
        // Insert itemin array at new location
        allFood.insert(movedFood, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(foodArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allFood, toFile: foodArchiveURL.path)
    }
    
    init() {
        if let archivedFood = NSKeyedUnarchiver.unarchiveObject(withFile: foodArchiveURL.path) as? [Food] {
            allFood += archivedFood
        }
    }
}
