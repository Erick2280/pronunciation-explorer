import Foundation
import SwiftUI

public struct RhymeView: View {
    public var wordA: WordEntry
    public var wordB: WordEntry
    public var combinedWords: [[(name: String, stressMark: Int?)]]

    public init(wordA: WordEntry, wordB: WordEntry) {
        self.wordA = wordA
        self.wordB = wordB
        self.combinedWords = RhymeChecker.shared.combineTwoWordEntries(wordA: wordA, wordB: wordB)
    }
    
    public var body: some View {
        
        VStack(alignment: .center) {
                  
            
            if (self.wordA.existsOnDictionary &&
                self.wordB.existsOnDictionary) {
                ScrollView(.horizontal) {
                                        
                    HStack(alignment: .top) {
                        ForEach(0..<combinedWords.count, id: \.self) { index in
                            CombinedPhonemeView(combinedPhoneme: self.combinedWords[index])
                        }
                    }
                }
                
                RhymeTypeView(rhymeEntry: RhymeEntry(wordA: wordA, wordB: wordB))

            } else {
                if (wordA.wordName.contains(" ") || wordB.wordName.contains(" ")) {
                    InformationText(text: "Please type only one word in each field, or go to Text page :)")
                } else if (wordA.wordName == "") {
                    InformationText(text: "Please type a word in the first field. What about the word \"\(PronunciationDictionary.shared.getRandomWord())\"?")
                } else if (wordB.wordName == "") {
                    InformationText(text: "Please type a word in the second field.")
                } else if (!wordA.existsOnDictionary) {
                    InformationText(text: "The word in the first field doesn't appear to be in the dictionary :/")
                } else if (!wordB.existsOnDictionary) {
                    InformationText(text: "The word in the second field doesn't appear to be in the dictionary :/")
                }
            }
            
        }
    }
}

struct CombinedPhonemeView: View {
    var combinedPhoneme: [(name: String, stressMark: Int?)]
    
    var body: some View {
        VStack(alignment: .center) {
            
            
            Rectangle()
                .frame(height: 4, alignment: .bottom)
                .foregroundColor(Colorizer.shared.getColorFromPhoneme(phoneme: combinedPhoneme[0].name)!)
            
            Text(self.combinedPhoneme[0].name)
                .font(Font.system(size: 16)).bold()
            
            if (self.combinedPhoneme[0].stressMark != nil) {
                Circle()
                    .fill(Colorizer.shared.getColorFromStressMark(stressMark: self.combinedPhoneme[0].stressMark!)!)
                    .frame(width: 8, height: 8)
            } else {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 8, height: 8)
            }
            
            if (combinedPhoneme.count > 1) {
                Rectangle()
                    .frame(height: 4, alignment: .bottom)
                    .foregroundColor(Colorizer.shared.getColorFromPhoneme(phoneme: combinedPhoneme[1].name)!)
                
                Text(self.combinedPhoneme[1].name)
                    .font(Font.system(size: 16)).bold()
                
                if (self.self.combinedPhoneme[1].stressMark != nil) {
                    Circle()
                        .fill(Colorizer.shared.getColorFromStressMark(stressMark: self.combinedPhoneme[1].stressMark!)!)
                        .frame(width: 8, height: 8)
                }
            }

        }.frame(minWidth: 40)
    }
}

struct RhymeTypeView: View {
    var rhymeEntry: RhymeEntry
    
    var body: some View {
        VStack {
            if (rhymeEntry.rhymeType == .perfectSingle) {
                InformationText(text: "It looks like a perfect (single) rhyme!", alignment: .leading, textAlignment: .leading)
            } else if (rhymeEntry.rhymeType == .perfectDouble) {
                InformationText(text: "It looks like a perfect (double) rhyme!", alignment: .leading, textAlignment: .leading)
            } else if (rhymeEntry.rhymeType == .perfectDactylic) {
                InformationText(text: "It looks like a perfect (dactylic) rhyme!", alignment: .leading, textAlignment: .leading)
            } else if (rhymeEntry.rhymeType == .identical) {
                InformationText(text: "It looks like an identical rhyme!", alignment: .leading, textAlignment: .leading)
            } else if (rhymeEntry.rhymeType == .imperfect) {
                InformationText(text: "It looks like an imperfect rhyme!", alignment: .leading, textAlignment: .leading)
            } else if (rhymeEntry.rhymeType == .assonant) {
                InformationText(text: "It looks like an assonant rhyme!", alignment: .leading, textAlignment: .leading)
            } else if (rhymeEntry.rhymeType == .consonant) {
                InformationText(text: "It looks like a consonant rhyme!", alignment: .leading, textAlignment: .leading)
            } else {
                InformationText(text: "It doesn't seem to rhyme...", alignment: .leading, textAlignment: .leading)
            }
        }.frame(height: 40)
    }
}
