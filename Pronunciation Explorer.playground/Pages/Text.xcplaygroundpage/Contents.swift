/*:
 
 # Exploring text...

 ## What's this?
In this page, **you can explore an entire text**. How about typing a poem, or the lyrics of a song you like? Just change the text variable in the code below and run the playground.
 
You may need to scroll the view vertically and horizontally to see all of the content.
 
Note the ends of each verse: if they rhyme, they probably have lines with similar colors.
    
*/

var text: String =
"""
Approach! the moment flies!
Thou sweetheart of the South!
Come! mingle with night's mysteries
The red rose of thy mouth,
The starlight of thine eyes.
Approach! the moment flies!
"""

import SwiftUI
import PlaygroundSupport
 
struct ContentView: View {
    @State var showPhonemeDetails = true
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack() {
                Text("Text")
                    .font(.custom("Helvetica Neue", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Toggle("Show phoneme details", isOn: $showPhonemeDetails)
            }
            
            TextView(textExplorer: TextExplorer(text: text), showPhonemeDetails: showPhonemeDetails)

        }.padding()
        
    }
}

let host = UIHostingController(rootView: ContentView())
host.preferredContentSize = CGSize(width: 600, height: 380)
PlaygroundPage.current.liveView = host
