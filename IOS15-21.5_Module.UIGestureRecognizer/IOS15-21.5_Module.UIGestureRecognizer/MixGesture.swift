//
//  MixGesture.swift
//  IOS15-21.5_Module.UIGestureRecognizer
//
//  Created by DiTRy on 15.01.2022.
//

import UIKit

class MixGesture: UIGestureRecognizer {
    
    let requireMovements = 2
    let distanceForMixGesture = 35
    
    enum MixingGestureDirection {
        case left
        case right
        case undefined
    }
    
    var mixingNumber = 0
    var mixingStartPoint: CGPoint = .zero
    var finalDirection: MixingGestureDirection = .undefined

    override func reset() { //  Сброс — в reset-методе у нас будет обнуляться mixingNumber, mixingStartPoint приобретёт значение .zero, а finalDirection станет .undefined. Также зададим условие для  state — если распознаватель в состоянии готовности, то он у нас будет фейлиться
        //print("MixGesture: func reset")
        mixingNumber = 0
        mixingStartPoint = .zero
        finalDirection = .undefined
        
        if state == .possible {
            state = .failed
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {  //  touchesBegan — у нас происходит тап по экрану, значит, жест начинается. При этом mixingStartPoint должен обновляться
        //print("MixGesture: func touchesBegan")
        guard let touch = touches.first else {
            return
        }
        mixingStartPoint = touch.location(in: view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {  //  touchesMoved — так как движение в нашем случае является базой кастомного жеста, то здесь помимо стандартной обработки нажатий, нам понадобится несколько переменных и условия для них
        //print("MixGesture: func touchesMoved")
        guard let touch = touches.first else { return }
        let mixingLocation = touch.location(in: view) //  отражает расположение жеста
        let horizontalDifference = mixingLocation.x - mixingStartPoint.x    //  считает разницу локации жеста и самой начальной точки жеста
        // Условие
        if abs(horizontalDifference) < CGFloat(distanceForMixGesture) {
            return
        }
        
        let direction: MixingGestureDirection   //  создадим переменную типа MixingGestureDirection
        
        if horizontalDifference < 0 {   //   И дальше мы будем делать проверку у horizontalDifference на отрицательные значения
            direction = .left
        } else {
            direction = .right
        }
        
        //  проверим finalDirection на все значения энума
        if finalDirection == .undefined || (finalDirection == .left && direction == .right) || (finalDirection == .right && direction == .left) {
            
            //  обновим внутри if-closure переменные, созданные в начале метода
            mixingStartPoint = mixingLocation
            finalDirection = direction
            mixingNumber += 1
        }
        
        //  state в нашем случае проверяется на готовность рекогнайзера и на количество насчитанных движений при тряске вью-элемента. В итоге, если state принимает значение possible, а число движений насчитано больше, чем требовалось, то рекогнайзер отключается
        if state == .possible && mixingNumber > requireMovements {
            state = .ended
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {  //  здесь мы будем вызывать reset
        //print("MixGesture: func touchesEnded")
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {  //  здесь тоже будет вызываться сброс рекогнайзера
        //print("MixGesture: func touchesCancelled")
        reset()
    }
}
