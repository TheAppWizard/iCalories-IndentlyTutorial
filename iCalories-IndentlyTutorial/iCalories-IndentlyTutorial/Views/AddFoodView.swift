//
//  AddFoodView.swift
//  iCalories-IndentlyTutorial
//
//  Created by Shreyas Vilaschandra Bhike on 11/02/24.
//

import SwiftUI

struct AddFoodView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    
    //Dissmiss -> PopOut
    @Environment(\.dismiss) var PopOut
    
    
    
    //Variables
    @State private var name = ""
    @State private var calories : Double = 0
    @State private var star = false
    @State private var mealType = ""
    
    
    
    var body: some View {
        Form{
            Section{
                //Add Star
                HStack{
                    Spacer()
                    Button(action: {
                        star.toggle()
                           }) {
                        Image(systemName: star ? "star.fill" : "star")
                        .foregroundColor(star ? .yellow : .gray)
                        .font(.system(size: 30))
                     }
                }.padding()
                
                
                TextField("Food Name",text: $name)
                    .font(.system(size: 35))
                TextField("Meal Type",text: $mealType)
                
                
                VStack{
                    HStack{
                        Text("Calories : \(Int(calories))")
                        Spacer()
                        
                        
                    }
                    
                    //Add Slider
                    Slider(value: $calories , in: 0...1000,step: 10)
                    
                    
                    HStack{
                        Spacer()
//                        Button(action: {
//                                 PopOut()
//                               }) {
//                                   Text("C A N C E L")
//                                    .foregroundColor(.red)
//                                    .padding()
//                                    .background(
//                                    RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.red, lineWidth: 2))
//                                    .padding(.horizontal, 2)
//                            
//                         }
                        Button(action: {
                                DataController()
                                .addFood(name: name, mealType: mealType, calories: calories, star: star, context: managedObjContext)
                            
                                 PopOut()
                               }) {
                                   
                                   Text("S U B M I T")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                     RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                                  )
                                    .padding(.horizontal, 2)
                            
                         }
                    }
                }
            }
        }
    }
}

#Preview {
    AddFoodView()
}
