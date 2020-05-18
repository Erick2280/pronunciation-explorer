import Foundation

public class PronunciationDictionary {
    let dictionary: [String: String]
    
    static public let shared = PronunciationDictionary()
    
    private init() {
        // Imports cmudict into a Dictionary
        var newDictionary = [String: String]()
        if let csvUrlPath = Bundle.main.url(forResource: "Dictionaries/cmudict", withExtension: "csv") {
            let csvData = try! String(contentsOf: csvUrlPath, encoding: .utf8)
            let csvLines = csvData.components(separatedBy: NSCharacterSet.newlines)

            for line in csvLines {
                let lineComponents = line.components(separatedBy: ",")
                if (lineComponents.count > 1) {
                    newDictionary[lineComponents[0]] = lineComponents[1]
                }
            }

        } else {
            print("Error on CSV parsing. The cmudict.csv file is in the Resources/Dictionaries directory?")
        }
        self.dictionary = newDictionary
    }
    
    public func getPronunciation(for word: String, getAlternative: Bool = false, removeStressMarks: Bool = false) -> [String]? {
        // Get the pronunciation of a word
        var key = word.lowercased()
        
        if (getAlternative) {
            key = key + "(2)"
        }
        
        guard let pronunciationString = dictionary[key] else {
            return nil
        }
        
        var phonemes = pronunciationString.components(separatedBy: NSCharacterSet.whitespaces)
        
        if (removeStressMarks) {
            for (index, phoneme) in phonemes.enumerated() {
                phonemes[index] = phoneme.replacingOccurrences(of: "[0-2]", with: "", options: .regularExpression)
            }
        }
        
        return phonemes
    }
    
    public func getStressMarks(for word: String, getAlternative: Bool = false) -> [Int?]? {
        // Get the stress markers of a word's vowels
        var key = word.lowercased()
        
        if (getAlternative) {
            key = key + "(2)"
        }
        
        guard let pronunciationString = dictionary[key] else {
            return nil
        }
        
        let phonemes = pronunciationString.components(separatedBy: NSCharacterSet.whitespaces)
        var stressMarks: [Int?] = []
        
        for phoneme in phonemes {
            if (phoneme.contains("0")) {
                stressMarks.append(0)
            } else if (phoneme.contains("1")) {
                stressMarks.append(1)
            } else if (phoneme.contains("2")) {
                stressMarks.append(2)
            } else {
                stressMarks.append(nil)
            }
        }
        
        return stressMarks
    }
    
    public func isAlternativePronunciationAvailable(for word: String) -> Bool {
        // Check if there is an alternative pronunciation for a word
        if (dictionary[word.lowercased() + "(2)"] != nil) {
            return true
        } else {
            return false
        }
    }
    
    public func getRandomWord() -> String {
        // Get a random word from the dictionary
        var randomWord = dictionary.randomElement()!.key
        while (randomWord.contains("(")) {
            randomWord = dictionary.randomElement()!.key
        }
        return randomWord;
    }
}

public class WordEntry {
    let wordName: String
    let existsOnDictionary: Bool
    let pronunciation: [String]
    let stressMarks: [Int?]
    
    public init(wordName: String) {
        self.wordName = wordName.lowercased()
        if let pronunciation = PronunciationDictionary.shared.getPronunciation(for: wordName, removeStressMarks: true) {
            self.existsOnDictionary = true
            self.pronunciation = pronunciation
            self.stressMarks = PronunciationDictionary.shared.getStressMarks(for: wordName)!
        } else {
            self.existsOnDictionary = false
            self.pronunciation = []
            self.stressMarks = []
        }
    }
}
