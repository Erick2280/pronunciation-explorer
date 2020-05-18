/*:
 
# Exploring pronunciation...

## What's this?
 
This is a pronunciation explorer. To get started, **just run the playground and type an English word**. The playground will show you how to pronounce it. In the next pages, you can learn more about rhymes and texts.
 
## A little about pronunciation and phonemes
 
**Have you noticed that sometimes two very similar words can have completely different pronunciations?** Take _love_ and _move_ as an example: the sound of "o" is not the same.
 
That's right: the letters of a word don't always reveal everything about it. For a native speaker, it can be simple to decipher the pronunciation, but it can be difficult for those learning English.
 
To understand and express these sounds, **phonemes** were created. A phoneme represents the smallest sound unit of the language, even less than the syllables. Combined, they form the sound of words and sentences.
 
When you type a word on the playground, its phonemes are shown. Try typing _love_ and then _move_. You will see the difference in pronunciation!
 
## What are these colored lines?
 
Have you ever stopped to think about how we move the air to generate the sound of speech? The colored lines represent just that.

Each color represents a different way of this movement. For example, when we say "n", the sound resonates in the nasal cavity, which is why we call that sound "nasal". We represent it with a pink line. Similar sounds will have similar colors :)
 
The full list of colors and an approximate description of the sound are described below:
 
- **Vowel**: air passes freely through the mouth (blue)
- **Semivowel**: air passes almost freely through the mouth, resembling a vowel (purple)
- **Stop**: the vocal tract is blocked, and the air doesn't pass (red)
- **Fricative**: air passes through a narrow channel, but not completely blocked (yellow)
- **Affricate**: starts as a stop, but ends as a fricative (orange)
- **Aspirate**: breath that accompanies air release (brown)
- **Nasal**: sound resonates in the nasal cavity (pink)
- **Liquid**: sound vibrates slightly, or passes through a narrow channel, but lighter than a fricative (green)
 
## And how about these colored dots?
 
They show the intensity, or _stress_, of a **vowel** in the word. Take the words _caring_ and _wing_ as an example. You notice that, although they have the same suffix _ing_, the pronunciation in _wing_ is much more stressed.
    
In English, there are two types of stress: **primary** and **secondary**. Primary stress is stronger than secondary stress. You can notice the difference in the words _organization_ and _accumulation_.

The dark blue dots represent primary stress, the light blue ones represent secondary stress, and the gray ones represent no stress.

## What's next?
 
Go to the Rhyme page to learn about rhyming.
    
*/


import SwiftUI
import PlaygroundSupport
 
struct ContentView: View {
    @State private var word: String = "acknowledgements"
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Word")
                .font(.custom("Helvetica Neue", size: 32))
            
            HStack {
                TextField("Enter an English word...", text: $word)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            
            WordView(word: WordEntry(wordName: word))
                .frame(height: 180)
            
        }.padding()
        
    }
}

let host = UIHostingController(rootView: ContentView())
host.preferredContentSize = CGSize(width: 600, height: 380)
PlaygroundPage.current.liveView = host
