//
//  ContentView.swift
//  IOS15-43.4_Module.SwiftUI.FinalProject
//
//  Created by DiTRy on 09.07.2022.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        NavigationView {
            
            List(brandsArray) { brand in
                NavigationLink(destination: ModelsView(carsOfBrand: brand.car, brand: brand.brand)) {
                    VStack {
                        Spacer()
                        Text(brand.brand)
                            .fontWeight(.bold)
                            .padding(.trailing)
                            .font(.system(size: 24))
                        Spacer()
                    }
                }
            }
            .navigationTitle("Марки авто")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ModelsView: View {
    @State var becomeModal: Bool = false
    let carsOfBrand: [Car]
    let brand: String

    var body: some View {
        List(carsOfBrand) { car in
            VStack {
                Spacer()
                HStack {
                    Image(car.photo).resizable()
                        .scaledToFit()
                        .frame(width: 80, alignment: .center)
                    Spacer()
                    Text(car.model)
                        .fontWeight(.bold)
                        .padding(.trailing)
                        .font(.system(size: 27))
                    Spacer()
                    Button("") {
                        print("Tapped")
                        self.becomeModal.toggle()
                    }
                    .sheet(isPresented: $becomeModal, content: {
                        DetailView.init(becomeModal: self.$becomeModal, currentCar: car)
                    })
                    .padding(.leading)
                }
                Spacer()
            }
        }
        .navigationTitle(brand)
    }
}

struct DetailView: View {
    @Binding var becomeModal: Bool
    let currentCar: Car
    var body: some View {
        VStack {
            Spacer()
            Text(currentCar.model)
                .font(.system(size: 48))
                .fontWeight(.bold)
            Spacer()
            Image(currentCar.photo).resizable()
                .scaledToFit()
            Spacer()
            ScrollView {
                Text(currentCar.description)
                    .padding(.horizontal, 10.0)
            }
            

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ModelsView_Previews: PreviewProvider {
    static var previews: some View {
        ModelsView(carsOfBrand: nissanArray, brand: "Nissan")
    }
}
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(becomeModal: .constant(true), currentCar: Car(model: "Murano", photo: "Murano", description: "Nissan Murano — среднеразмерный кроссовер японской компании Nissan, выпускающийся с 2002 года. Автомобиль разработан в Nissan America в Ла-Холье на платформе Nissan FF-L как первый кроссовер Nissan для США и Канады. Европейская версия Nissan Murano поступила в продажу в 2004 году. Назван в честь одного из островов в Италии — Мурано."))
    }
}
