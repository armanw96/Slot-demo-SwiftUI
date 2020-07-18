//
//  cardView.swift
//  slot demo
//
//  Created by Arman Wirawan on 6/21/20.
//  Copyright © 2020 Arman Wirawan. All rights reserved.
//

import SwiftUI

struct cardView: View {
    
    @Binding var symbol:String
    @Binding var backgrounds:Color
    
    
    var body: some View {
        
        Image(symbol).resizable().aspectRatio(1, contentMode: .fit).background(backgrounds.opacity(0.5)).cornerRadius(20)
        
        
    }
}

struct cardView_Previews: PreviewProvider {
    static var previews: some View {
        cardView(symbol: Binding.constant("cherry"), backgrounds: Binding.constant(Color.green))
    }
}
