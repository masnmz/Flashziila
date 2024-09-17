//
//  CardView.swift
//  Flashziila
//
//  Created by Mehmet Alp Sönmez on 16/07/2024.
//

import SwiftUI

struct CardBackgroundModifier: ViewModifier {
    var offset: CGSize
    var accessibilityDifferentiateWithoutColor: Bool

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        accessibilityDifferentiateWithoutColor
                        ? .white
                        : offset.width == 0
                            ? Color.white
                            : offset.width > 0
                                ? Color.green
                                : Color.red
                    )
            )
    }
}

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    let card: Card
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white.opacity( 1 - Double(abs(offset.width / 50))))
                .modifier(CardBackgroundModifier(offset: offset, accessibilityDifferentiateWithoutColor: accessibilityDifferentiateWithoutColor))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.blue)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        removal?()
                    } else {
                        offset = .zero
                        isShowingAnswer = false
                        
                    }
                }
            )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
    }
}

#Preview {
    CardView(card: Card.example)
}
