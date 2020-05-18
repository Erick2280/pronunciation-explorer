/*:
 
# Exploring rhymes...

## What's this?
 
This is a rhyme explorer. To get started, **just run the playground and type two English words**. You can compare the pronunciation of both words, whether they rhyme or not, and what type of rhyme is.
 
## A little about rhymes
 
Two words rhyme when the sound near their end is similar. Rhymes can create a pleasant sound for poems and music.
 
The rhymes are considered perfect when the final stressed vowel (remember the colored dots!) of the word and all subsequent sounds are the same.

There are many classifications for rhymes, but this playground can detect the following:

### Perfect
 
- **Single** (or masculine): a rhyme in which the stressed syllable is the last of the words (like _map_ and _clap_)
- **Double** (or feminine): a rhyme in which the stressed syllable is the penultimate of the words (like _dancing_ and _glancing_)
- **Dactylic**: a rhyme in which the stressed syllable is the antepenultimate of the words (like _mystical_ and _statistical_)

## Others
 
- **Identical**: when all the sound between the words matches (like _gun_ and _begun_ or _bare_ and _bair_)
- **Imperfect**: a rhyme similar to the perfect ones, but stress don't quite match (like _cling_ and _caring_)
- **Assonant**: two words with same vowels, but different consonants (like _shake_ and _hate_)
- **Consonant**: two words with same consonants, but different vowels (like _ball_ and _bell_)
 
 ## What's next?
  
 Go to the Text page to play with texts.
 
 */

import SwiftUI
import PlaygroundSupport
 
struct ContentView: View {
    @State private var wordA: String = "mystical"
    @State private var wordB: String = "statistical"
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Rhymes")
                .font(.custom("Helvetica Neue", size: 32))
            
            HStack {
                TextField("Enter an English word...", text: $wordA)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                TextField("Enter another English word...", text: $wordB)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            RhymeView(wordA: WordEntry(wordName: wordA), wordB: WordEntry(wordName: wordB))
                .frame(height: 180)
            
        }.padding()
        
    }
}

let host = UIHostingController(rootView: ContentView())
host.preferredContentSize = CGSize(width: 600, height: 380)
PlaygroundPage.current.liveView = host
