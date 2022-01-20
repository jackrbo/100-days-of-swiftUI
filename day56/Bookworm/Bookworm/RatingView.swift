//
//  RatingView.swift
//  Bookworm
//
//  Created by Richard-Bollans, Jack on 17/01/2022.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    
    var body: some View {
        HStack {
            Text(label)
            ForEach(1..<maxRating+1) {number in
                image(for: number)
                    .foregroundColor(number <= rating ? onColor : offColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    func image(for number: Int) -> Image{
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
