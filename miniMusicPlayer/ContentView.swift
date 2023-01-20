//
//  ContentView.swift
//  miniMusicPlayer
//
//  Created by Peter Clarke on 20.01.2023.
//

import SwiftUI
import AVFoundation

class PlayerViewModel : ObservableObject{
    @Published public var maxDuration = 0.0
    private var player : AVAudioPlayer?
    
    public func play(){
        playSong(name: "test1")
        player?.play()
    }
    
    public func stop (){
        player?.stop()
    }
    
    public func setTime(value: Float){
        
        guard let time = TimeInterval(exactly: value) else{
            return
        }
        player?.currentTime = time
        player?.play()
    }
    
    private func playSong(name: String){
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else {
            return
        }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
}


struct ContentView: View {
    @State private var progress : Float = 0
    @ObservedObject var viewModel = PlayerViewModel()
    var body: some View {
        VStack{
            Slider(value: Binding(get:{
                Double(self.progress)
            },
                                  set: {
                newValue in self.progress = Float(newValue)
                self.viewModel.setTime(value: Float(newValue))
            }), in: 0...viewModel.maxDuration)
            .padding().accentColor(Color.pink)
            
            HStack{
                Button(action: {
                    self.viewModel.stop()
                }, label: {
                    Text("Pause").foregroundColor(Color.black)
                })
                .frame(width: 100, height: 50)
                .background(Color.yellow)
                .cornerRadius(20)
                Button(action: {
                    self.viewModel.play()
                }, label: {
                    Text("Play")
                        .foregroundColor(Color.black)
                })
                
                .frame(width: 100, height: 50)
                
                .background(Color.yellow)
                .cornerRadius(20)
                // .position(x : 180 , y : 450)
                
                Button(action: {
                    print("Next")
                }, label: {
                    Text("Next")
                        .foregroundColor(Color.black)
                })
                .frame(width: 100, height: 50)
                .background(Color.yellow)
                .cornerRadius(20)
                
            }
            
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
