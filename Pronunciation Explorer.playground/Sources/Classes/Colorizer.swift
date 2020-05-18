import Foundation
import SwiftUI

public class Colorizer {
    let phonemeColors: [String: Color]
    let stressMarkColors: [Int: Color]
    
    static public let shared = Colorizer()
    
    private init() {
        
        let vowel = Color(red: 0/255, green: 107/255, blue: 255/255) // Blue
        let semivowel = Color(red: 82/255, green: 42/255, blue: 167/255) // Purple
        let stop = Color(red: 242/255, green: 0/255, blue: 0/255) // Red
        let fricative = Color(red: 255/255, green: 247/255, blue: 32/255) // Yellow
        let affricate = Color(red: 255/55, green: 139/255, blue: 20/255) // Orange
        let aspirate = Color(red: 107/255, green: 61/255, blue: 49/255) // Brown
        let nasal = Color(red: 255/255, green: 69/255, blue: 235/255) // Pink
        let liquid = Color(red: 33/255, green: 202/255, blue: 64/255) // Green
        
        phonemeColors = [
            "AA": vowel,
            "AE": vowel,
            "AH": vowel,
            "AO": vowel,
            "AW": vowel,
            "AY": vowel,
            "B": stop,
            "CH": affricate,
            "D": stop,
            "DH": fricative,
            "EH": vowel,
            "ER": vowel,
            "EY": vowel,
            "F": fricative,
            "G": stop,
            "HH": aspirate,
            "IH": vowel,
            "IY": vowel,
            "JH": affricate,
            "K": stop,
            "L": liquid,
            "M": nasal,
            "N": nasal,
            "NG": nasal,
            "OW": vowel,
            "OY": vowel,
            "P": stop,
            "R": liquid,
            "S": fricative,
            "SH": fricative,
            "T": stop,
            "TH": fricative,
            "UH": vowel,
            "UW": vowel,
            "V": fricative,
            "W": semivowel,
            "Y": semivowel,
            "Z": fricative,
            "ZH": fricative,
            "": .clear
        ]
        
        stressMarkColors = [
            0: Color(red: 168/255, green: 168/255, blue: 168/255), // Gray
            1: Color(red: 77/255, green: 200/255, blue: 238/255), // Light blue
            2: Color(red: 0/255, green: 13/255, blue: 255/255) // Dark blue
        ]
    }
    
    public func getColorFromPhoneme(phoneme: String) -> Color? {
        let key = phoneme.replacingOccurrences(of: "[0-2]", with: "", options: .regularExpression)
        return phonemeColors[key]
    }
    
    public func getColorFromStressMark(stressMark: Int) -> Color? {
        return stressMarkColors[stressMark]
    }
}
