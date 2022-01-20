//
//  CustomCircleView.swift
//  IOS15-21.7_Module.MiniGame
//
//  Created by DiTRy on 16.01.2022.
//

import UIKit

@IBDesignable class CustomCircleView: UIView {
    
    var customCircleSubView: UIView!  //  customCircleSubView в качестве нашего кастомного вью
    var xibName: String = "CircleView"  //  Имя xib-файла
    
    @IBInspectable var customCircleViewBackground: UIColor {  //  @IBInspectable добавляется чтобы свойство кастомного вью мы могли редактировать прямо в сториборде
        
        get { return customCircleSubView.backgroundColor! }
        set(backgroundColor) { customCircleSubView.backgroundColor = backgroundColor}
    }
    
    override init(frame: CGRect) {  //  Инициализатор, который определит форму. У frame тип данных CGRect
        super.init(frame: frame)
        setCustomCircleView()
    }
    
    required init?(coder: NSCoder) {  //  У нашего класса инициализатор может быть только при том условии, когда в классе будет прописан обязательный (required init) инициализатор
        super.init(coder: coder)
        setCustomCircleView()
    }
    

    
    func getFromXib() -> UIView {   //  Функция, которая получает UIView из xib-файла и возвращает этот UIView. Это нужно для отображения кастомного вью на сториборде
        
        let bundle = Bundle(for: type(of: self))    //  Получаем сам проект через bundle — поэтому и делаем константу с bundle, чтобы система определила bundle автоматически
        let xib = UINib(nibName: xibName, bundle: bundle)   //  Получаем название xib-файла при помощи двух параметров nibName и bundle
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView  //  Получаем вью как один элемент из массива, который у нас получился в результате вызова метода instantiate с xib — при этом в нашем массиве всего один элемент, а значит именно его нужно перевести в UIView через type casting
        return view //  Возвращаем вью
    }
    
    func setCustomCircleView() {  //  Настраиваем кастомный сабвью
        
        customCircleSubView = getFromXib()  //  Получаем вью с помощью метода getFromXib()
        customCircleSubView.frame = bounds  //  Определяем границы вью через frame
        customCircleSubView.autoresizingMask = [.flexibleWidth, .flexibleHeight]    //  Определяем размещение в пределах заданных границ — autoresizingMask нам в помощь
        customCircleSubView.layer.cornerRadius = frame.size.width / 2   //  Выставляем радиус границ равный половине ширины, чтобы получить круг
        customCircleSubView.backgroundColor = .blue
        addSubview(customCircleSubView) //  Добавляем вью как subview
        //setCustomView() нужно вызвать через инициализаторы
    }
}
