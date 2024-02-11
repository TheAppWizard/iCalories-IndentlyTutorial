//
//  ContentView.swift
//  iCalories-IndentlyTutorial
//
//  Created by Shreyas Vilaschandra Bhike on 10/02/24.
//


//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408


import SwiftUI
import CoreData



struct ContentView: View {
    var body: some View {
        FinalView()
    }
}



#Preview {
    ContentView()
}

















struct FinalView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    
    //Make Fetch request
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date,order: .reverse)]) var food : FetchedResults<Food>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack(alignment: .leading)  {
                   Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                    
                    //Create a List of Data
                    
                    List{
                        ForEach(food) {food in
                            NavigationLink(destination: Text("\(food.calories)")){
                                HStack{
                                    VStack(alignment : .leading,spacing: 6){
                                        HStack{
                                            Text(food.name!)
                                                .font(.system(size: 20))
                                            
                                            
                                            Text(" " + food.mealType!)
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 12))
                                        }
                                        
                                        Text("\(Int(food.calories))")
                                        + Text(" calories").foregroundStyle(.red)
                                        
                                        
                                    }
                                    
                                    Spacer()
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Image(systemName: food.star ? "star.fill" : "star")
                                                .foregroundColor(food.star  ? .yellow : .gray)
                                        }
                                        HStack{
                                            Spacer()
                                            Text(calculateTimeSince(date:food.date!))
                                                .foregroundStyle(.gray).italic()
                                        }
                                       
                                    }
                                }
                               
                            }
                        }.onDelete(perform: onDeleteFood)
                    }.listStyle(.plain)
                    
                    
                    
                    
                    
                    
                    
                }.navigationTitle("iCalories")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button{
                                showingAddView.toggle()
                            }
                            label : {
                                Label("Add",systemImage: "plus.circle")
                            }
                            }
                        
                            ToolbarItem(placement: .navigationBarLeading){
                                EditButton()
                            }
                        }
                        .sheet(isPresented: $showingAddView){
                            AddFoodView()
                        }
               
                    }
            }
        }
    
    private func onDeleteFood(offsets: IndexSet){
        withAnimation{
            offsets.map{
                food[$0]
            }.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
        
    }
    
    
    private func totalCaloriesToday() -> Double{
        var calororiesToday : Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                calororiesToday += item.calories
            }
        }
        
        
        
        
        return calororiesToday
    }
}

