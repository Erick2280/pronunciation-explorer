import Foundation
import SwiftUI

public struct WordView: View {
    public var word: WordEntry

    public init(word: WordEntry) {
        self.word = word
    }
    
    public var body: some View {
        
        VStack(alignment: .center) {
                        
            if (self.word.existsOnDictionary) {
                ScrollView(.horizontal) {
                                        
                    HStack(alignment: .top) {
                        ForEach(0..<word.pronunciation.count, id: \.self) { index in
                            PhonemeView(phoneme: self.word.pronunciation[index], stressMark: self.word.stressMarks[index])
                        }
                    }
                                        
                }
                

            } else {
                if (word.wordName.contains(" ")) {
                    InformationText(text: "Please type only one word, or go to Text page :)")
                } else if (word.wordName == "") {
                    InformationText(text: "Please type a word. What about the word \"\(PronunciationDictionary.shared.getRandomWord())\"?")
                } else {
                    InformationText(text: "This word doesn't appear to be in the dictionary :/")
                }
            }
            
        }
    }
}

struct InformationText: View {
    var text: String
    var alignment: Alignment = .center
    var textAlignment: TextAlignment = .center
    
    var body: some View {
        Text(text)
            .font(Font.system(size: 16))
            .lineLimit(nil)
            .frame(maxWidth: .infinity, alignment: alignment)
            .multilineTextAlignment(textAlignment)
    }
}

struct PhonemeView: View {
    var phoneme: String
    var stressMark: Int?
    
    var body: some View {
        VStack(alignment: .center) {
            
            Rectangle()
                .frame(height: 4, alignment: .bottom)
                .foregroundColor(Colorizer.shared.getColorFromPhoneme(phoneme: phoneme)!)
            
            Text(self.phoneme)
                .font(Font.system(size: 16)).bold()
            
            if (self.stressMark != nil) {
                Circle()
                    .fill(Colorizer.shared.getColorFromStressMark(stressMark: stressMark!)!)
                    .frame(width: 8, height: 8)
            }

        }.frame(width: 40)
    }
}




