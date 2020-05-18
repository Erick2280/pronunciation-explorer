import Foundation

public class TextExplorer {
    let textPronunciations: [[(phonemes: [String], stressMarks: [Int?])]]
    
    public init(text: String) {
        // Get the pronunciation of all words in the text
        var filteredText = text.lowercased()
        filteredText = filteredText.replacingOccurrences(of: "[^a-z'\n ]+", with: "", options: .regularExpression)
        let textLines = filteredText.components(separatedBy: NSCharacterSet.newlines)
        var textPronunciations: [[(phonemes: [String], stressMarks: [Int?])]] = []
        
        for line in textLines {
            let lineWords = line.components(separatedBy: NSCharacterSet.whitespaces)
            var linePronunciations: [(phonemes: [String], stressMarks: [Int?])] = []
            
            for word in lineWords {
                if let pronunciation = PronunciationDictionary.shared.getPronunciation(for: word) {
                    let stressMark = PronunciationDictionary.shared.getStressMarks(for: word)!
                    linePronunciations.append((pronunciation, stressMark))
                } else {
                    linePronunciations.append((phonemes: [String](repeating: "", count: word.count), stressMarks: [Int?](repeating: nil, count: word.count)))
                }
            }
            
            textPronunciations.append(linePronunciations)
        }
        self.textPronunciations = textPronunciations
    }
}
