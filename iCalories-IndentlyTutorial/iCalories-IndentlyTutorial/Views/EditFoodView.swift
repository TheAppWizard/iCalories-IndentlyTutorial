//
//  EditFoodView.swift
//  iCalories-IndentlyTutorial
//
//  Created by Shreyas Vilaschandra Bhike on 11/02/24.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var PopOut
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories : Double = 0
    @State private var star = false
    @State private var mealType = ""
    
    var body: some View {
        Form {
            Section() {
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...2000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editFood(food: food, name: name, mealType: mealType, calories: calories, star: star, context: managedObjContext)
                        PopOut()
                    }
                    Spacer()
                }
            }
        }
    }
}
