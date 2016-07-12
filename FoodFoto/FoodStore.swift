
import UIKit

class FoodStore {
    
    var allFood = [Food]()
    let foodArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("food.archive")
    }()
    
    func createFood() -> Food {
        let newFood = Food(random: true)
        
        allFood.append(newFood)
        
        return newFood
        
    }
    
    func removeFood(food: Food) {
        if let index = allFood.indexOf(food) {
            allFood.removeAtIndex(index)
        }
    }
    
    func moveFoodAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedFood = allFood[fromIndex]
        
        // Remove food from array
        allFood.removeAtIndex(fromIndex)
        
        // Insert itemin array at new location
        allFood.insert(movedFood, atIndex: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(foodArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allFood, toFile: foodArchiveURL.path!)
    }
    
    init() {
        if let archivedFood = NSKeyedUnarchiver.unarchiveObjectWithFile(foodArchiveURL.path!) as? [Food] {
            allFood += archivedFood
        }
    }
}