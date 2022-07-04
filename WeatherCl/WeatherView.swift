//
//  ContentView.swift
//  WeatherCl
//
//  Created by KARAN  on 09/02/22.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    @State var animate = false
    @State var endAnimate = false
    var body: some View {
        ZStack{
            LinearGradient(gradient : Gradient(colors: [.blue,.white]),startPoint: .topLeading,endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        VStack{
            Text(viewModel.cityName).font(.largeTitle).padding()
            Text(viewModel.tempreature).font(.system(size: 70)).bold()
            Text(viewModel.weatherIcon).font(.largeTitle).padding()
            Text(viewModel.weatherDescription)

        }.onAppear(perform: viewModel.refresh)
        }

    }
    
    func animation(){
        DispatchQueue.main.asyncAfter(deadline : .now() + 0.25){
            withAnimation(Animation.easeOut(duration: 0.45)){
                animate.toggle()
            }
            
            withAnimation(Animation.easeOut(duration: 0.35)){
                endAnimate.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel:  WeatherViewModel(weatherService: WeatherService())
                    )
    }
}
