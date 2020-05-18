import Foundation

public enum RhymeType {
    case none, identical, perfectSingle, perfectDouble, perfectDactylic, imperfect, assonant, consonant
}

public class RhymeChecker {
    
    static public let shared = RhymeChecker()

    private init() {}
        
    public func checkRhyme(pronunciationA: [String], pronunciationB: [String]) -> RhymeType {
        // Check if two words rhyme or not, and what type of rhyme is
        if (pronunciationA == pronunciationB) {
            return RhymeType.identical
        }

        var identicalPhonemes = 0
        var identicalVowels = 0
        
        var seemsPerfect = false
        var seemsIdentical = true
        
        for (phonemeA, phonemeB) in zip(pronunciationA.reversed(), pronunciationB.reversed()) {
            if (phonemeA == phonemeB) {
                identicalPhonemes += 1
                
                if (phonemeA.contains("0")) {
                    identicalVowels += 1
                }
                
                if (phonemeA.contains("1") || phonemeA.contains("2")) {
                    identicalVowels += 1
                    seemsPerfect = true
                }
            } else if (!seemsPerfect && phonemeA.replacingOccurrences(of: "[0-2]", with: "", options: .regularExpression) == phonemeB.replacingOccurrences(of: "[0-2]", with: "", options: .regularExpression)) {
                return RhymeType.imperfect
            } else {
                seemsIdentical = false;
                break;
            }
        }
        
        if (seemsIdentical) {
            return RhymeType.identical
        }
        
        switch identicalVowels {
            case 0:
                
                var vowelsA: [String] = []
                var vowelsB: [String] = []
                var consonantsA: [String] = []
                var consonantsB: [String] = []
                
                for (phonemeA, phonemeB) in zip(pronunciationA.reversed(), pronunciationB.reversed()) {
                    if (phonemeA.contains("0") || phonemeA.contains("1") || phonemeA.contains("2")) {
                        vowelsA.append(phonemeA)
                    } else {
                        consonantsA.append(phonemeA)
                    }
                    
                    if (phonemeB.contains("0") || phonemeB.contains("1") || phonemeB.contains("2")) {
                        vowelsB.append(phonemeB)
                    } else {
                        consonantsB.append(phonemeB)
                    }
                }
            
                if (vowelsA.count != 0 && vowelsA == vowelsB) {
                    return RhymeType.assonant
                } else if (consonantsA.count != 0 && consonantsA == consonantsB) {
                    return RhymeType.consonant
                } else {
                    return RhymeType.none
                }
                
            case 1:
                return RhymeType.perfectSingle
            case 2:
                return RhymeType.perfectDouble
            default:
                return RhymeType.perfectDactylic
        }
    }
    
    public func combineTwoWordEntries(wordA: WordEntry, wordB: WordEntry) -> [[(name: String, stressMark: Int?)]] {
        // Combine two words to get similar and different phonemes between them.
        var combinedEntries: [[(name: String, stressMark: Int?)]] = []
        
        let largestPronunciation = wordA.pronunciation.count > wordB.pronunciation.count ? wordA.pronunciation : wordB.pronunciation
        var smallestPronunciation = wordA.pronunciation.count > wordB.pronunciation.count ? wordB.pronunciation : wordA.pronunciation
        
        let largestStressMarksArray = wordA.stressMarks.count > wordB.stressMarks.count ? wordA.stressMarks : wordB.stressMarks
        var smallestStressMarkArray = wordA.stressMarks.count > wordB.stressMarks.count ? wordB.stressMarks : wordA.stressMarks
        
        let offsetSize = abs(wordA.pronunciation.count - wordB.pronunciation.count)
        let pronunciationOffset = [String](repeating: "", count: offsetSize)
        let stressMarksOffset = [Int?](repeating: nil, count: offsetSize)
        
        smallestPronunciation = pronunciationOffset + smallestPronunciation
        smallestStressMarkArray = stressMarksOffset + smallestStressMarkArray

        for index in 0..<largestPronunciation.count {
            
            var combinedPhonemes: [(name: String, stressMark: Int?)] = [(largestPronunciation[index], largestStressMarksArray[index])]
            if (largestPronunciation[index] != smallestPronunciation[index] ||
                largestStressMarksArray[index] != smallestStressMarkArray[index]) {
                combinedPhonemes.append((smallestPronunciation[index], smallestStressMarkArray[index]))
            }
            combinedEntries.append(combinedPhonemes)
        }
                
        return combinedEntries
    }
    
    
}

public class RhymeEntry {
    let wordA: WordEntry
    let wordB: WordEntry
    let rhymeType: RhymeType
    
    public init(wordA: WordEntry, wordB: WordEntry) {
        self.wordA = wordA
        self.wordB = wordB
        self.rhymeType = RhymeChecker.shared.checkRhyme(
            pronunciationA: PronunciationDictionary.shared.getPronunciation(for: wordA.wordName)!,
            pronunciationB: PronunciationDictionary.shared.getPronunciation(for: wordB.wordName)!)
    }
}
