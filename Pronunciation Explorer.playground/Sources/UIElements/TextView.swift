import Foundation
import SwiftUI

public struct TextView: View {
    public var textExplorer: TextExplorer
    public var showPhonemeDetails: Bool
    
    public init(textExplorer: TextExplorer, showPhonemeDetails: Bool) {
        self.textExplorer = textExplorer
        self.showPhonemeDetails = showPhonemeDetails
    }
    
    public var body: some View {
        
        ScrollView(.horizontal) {
            ScrollView(.vertical) {
                VStack(alignment: .trailing) {
                    ForEach(0..<textExplorer.textPronunciations.count, id: \.self) { index in
                        LineView(linePronunciations: self.textExplorer.textPronunciations[index], showPhonemeDetails: self.showPhonemeDetails)
                    }
                }
            }
        }
    }
}

struct LineView: View {
    var linePronunciations: [(phonemes: [String], stressMarks: [Int?])]
    var showPhonemeDetails: Bool
    
    var body: some View {
        HStack() {
            ForEach(0..<linePronunciations.count, id: \.self) { index in
                SeparatedWordView(phonemes: self.linePronunciations[index].phonemes, stressMarks: self.linePronunciations[index].stressMarks, showPhonemeDetails: self.showPhonemeDetails)
            }
        }
    }
}

struct SeparatedWordView: View {
    var phonemes: [String]
    var stressMarks: [Int?]
    var showPhonemeDetails: Bool

    var body: some View {
        HStack(alignment: .top) {
            if (self.showPhonemeDetails) {
                ForEach(0..<phonemes.count, id: \.self) { index in
                    PhonemeView(phoneme: self.phonemes[index], stressMark: self.stressMarks[index])
                }
            } else {
                ForEach(0..<phonemes.count, id: \.self) { index in
                    PhonemeColorView(phoneme: self.phonemes[index], stressMark: self.stressMarks[index])
                }
            }
        }
    }
}

struct PhonemeColorView: View {
    var phoneme: String
    var stressMark: Int?
    
    var body: some View {
        VStack(alignment: .center) {
            
            Rectangle()
                .frame(width: 20, height: 4, alignment: .bottom)
                .foregroundColor(Colorizer.shared.getColorFromPhoneme(phoneme: phoneme)!)

        }
    }
}


