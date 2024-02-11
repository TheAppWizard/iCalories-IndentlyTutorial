//
//  DataController.swift
//  iCalories-IndentlyTutorial
//
//  Created by Shreyas Vilaschandra Bhike on 11/02/24.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    //Exact Name From Group "Data Model"
    let container = NSPersistentContainer(name: "FoodModel")
    
    init(){
        container.loadPersistentStores{
            desc, error in
            
            if let error = error{
                print("Failed Loading with Error :: \(error.localizedDescription)")
                
            }
        }
    }
    
    
    func save (context : NSManagedObjectContext){
        do {
            try context.save()
            print("Data Saved in Model")
        }
        catch{
            print("Data Saving Failed")
        }
    }
    
    
    func addFood(name : String, mealType : String, calories : Double , star : Bool , context : NSManagedObjectContext){
        
        let food = Food(context: context)
        food.id = UUID()
        food.calories = calories
        food.date = Date()
        food.mealType = mealType
        food.name = name
        food.star = star
        
        //Call Save Function Here
        save(context: context)
    
    }
    
    
    func editFood(food : Food, name : String, mealType : String, calories : Double , star : Bool , context : NSManagedObjectContext){
        
        food.calories = calories
        food.date = Date()
        food.mealType = mealType
        food.name = name
        food.star = star
        
        
        //Call Save Function Here
        save(context: context)
    
    }
    
    
}
