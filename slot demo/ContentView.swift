//
//  ContentView.swift
//  slot demo
//
//  Created by Arman Wirawan on 6/21/20.
//  Copyright © 2020 Arman Wirawan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple", "cherry", "star"]
    @State private var numbers = Array(repeating: 0, count: 9)
    
    @State private var background = Array(repeating: Color.white, count: 9)
    @State private var Credits = 900
    private var betAmount = 10
    var body: some View {
        
        ZStack{
            //Background
            Rectangle().foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(.all)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(.all)
            VStack{
                
                Spacer()
                HStack{
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    
                    Text("SWIFTUI SLOTS").bold().foregroundColor(.white)
                    
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(2)
                // credit label
                // remember order of method is also important paddding comes first and then background color and then opacity and then corner radius
                Spacer()
                
                Text("Credits " + String(Credits)).bold().foregroundColor(.black).padding(.all, 10).background(Color.white).opacity(0.5)
                    .cornerRadius(15)
                
                // slot face
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        cardView(symbol: $symbols[numbers[0]], backgrounds: $background[0])
                        
                        cardView(symbol: $symbols[numbers[1]], backgrounds: $background[1])
                        
                        cardView(symbol: $symbols[numbers[2]], backgrounds: $background[2])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        cardView(symbol: $symbols[numbers[3]], backgrounds: $background[3])
                        
                        cardView(symbol: $symbols[numbers[4]], backgrounds: $background[4])
                        
                        cardView(symbol: $symbols[numbers[5]], backgrounds: $background[5])
                        Spacer()
                        
                    }
                    HStack{
                        //on the symbols number it signifies what index those picture are in. apple is inside index 0 cherry 1 and star is 2
                        Spacer()
                        cardView(symbol: $symbols[numbers[6]], backgrounds: $background[6])
                        
                        cardView(symbol: $symbols[numbers[7]], backgrounds: $background[7])
                        
                        cardView(symbol: $symbols[numbers[8]], backgrounds: $background[8])
                        
                        Spacer()
                    }
                    Spacer()
                    //Buttons
                    HStack(spacing: 20)
                    {
                        VStack{
                            Button(action: {
                                self.processResults()
                                
                                
                            }) {
                                Text("apples").bold().foregroundColor(Color.white).padding(.all, 10).padding([.leading, .trailing], 25).background(Color.pink).cornerRadius(20)
                                
                            }
                            
                            
                            Text("\(betAmount) credits")
                            
                        }
                        VStack{
                            Button(action: {
                                self.processResults(true)
                                
                                
                            }) {
                                Text("MAX apples").bold().foregroundColor(Color.white).padding(.all, 10).padding([.leading, .trailing], 25).background(Color.pink).cornerRadius(20)
                                
                            }
                            
                            
                            Text("\(betAmount * 5) credits")
                            
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                }
            }
            
        }
        
    }
    func processResults(_ isMax:Bool = false)
    {
        // turn the button white when you're just playing and not getting matches symbols
        
        //self.background[0] = Color.white you can do this 9 times but to make things easier like in the video youcan use teh map function instead
        
        self.background =  self.background.map({
            _ in Color.white
        })
        
        
        //the same thing here why do you need to let swift know numbers 0,1,2 is because of their index number. idk why they start with 0 maybe its to symbolize them in integer form that is easy to read but still those 0,1,2 are index of said pictures yo uhave to put them otherweise it won't work
        
        //do the 2 types of spins Max and just the middle row
        
        if isMax {
            
            self.numbers = self.numbers.map({_ in
                Int.random(in: 0...self.symbols.count - 1)
            })
        }
        else{
            // just the middle row
            //check images
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        // check winnings
        processWins(isMax)
        
        
    }
    
    
    func processWins(_ isMax: Bool = false){
        var Matches = 0
        
        if !isMax{
            
            // processing for single spin
            
            if isMatch(3, 4, 5){
                Matches += 1
            }
            
        }else{
    //processing max spin
    
    
    //Top row
    if isMatch (0, 1, 2){
        Matches += 1
    }
   
    
    //middle row
    if isMatch(3, 4, 5){
        Matches += 1
    }
    // bottom row
    
    if isMatch(6, 7, 8){
        Matches += 1
    }
    // Diagonal top left to bottom right
    if isMatch(0, 4, 8){
        Matches += 1
    }
    // Diagonal top right to bottom left
    if isMatch(2, 4, 6){
        Matches += 1
    }
    }
    //check winnings
    // or check matches
    if Matches > 0
    {
    //at least 1 win
    self.Credits +=  Matches * betAmount
    
    }else if !isMax {
    //0 wins 1 spin
    self.Credits -= betAmount
    }
    else if isMax{
    //0 wins max spin
    self.Credits -= betAmount * 2
    }
}

func isMatch (_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
    if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3] {
        
        self.background[index1] = Color.green
        self.background[index2] = Color.green
        self.background[index3] = Color.green
        
        return true
    }
    
    return false
}


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//check winnings
//if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2]{
//won
//self.Credits += self.betAmount * 10
//update background when winning
//self.background[0] = Color.green
//self.background[1] = Color.green
//self.background[2] = Color.green
