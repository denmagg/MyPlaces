//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Denis Medvedev on 25/06/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    var newPlace: Place?
    var imageIsChanged = false

    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
// MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            //определим AlertController
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            //определим для него 3 пользовательских действия
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            // setvalue - установка значения любого типа по ключу
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary )
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
           //впишем пользовательские действия в AlertController
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)

           //как любой контроллер вызовем его
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func setupVC() {
        //замена разлиновки на UIView (убирание полос снизу)
        tableView.tableFooterView = UIView()
        
        //блокируем кнопку пока поля не заполнены
        saveButton.isEnabled = false
        
        //добавим метод который отслеживающий изменение placeName (каждый раз при изменении placeName запускается метод textFieldChanged)
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    func saveNewPlace() {
        
        var image: UIImage?
        
        if imageIsChanged == true {
            image = placeImage.image
        } else {
            image = UIImage(named: "imagePlaceholder")
        }
        
        newPlace = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, image: image, restaurantImage: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

//MARK: Text field delegate
extension NewPlaceViewController: UITextFieldDelegate{
    //скрываем клавиатуру при нажатии на done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //метод определяющий доступность saveButton
    @objc private func textFieldChanged() {
        if placeName.text?.isEmpty == true {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}

//MARK: Work with image
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //создаем расширение где определяем метод ответственный за функционал нашего контроллера
    //UIImagePickerController.SourceType - VC  который управляет системными инттерфейсами для съемки фото, записи видео
    //и выбора изображений из библиотеки пользователя
    //в зависимости от источника контроллер представляет тот или иной интерфейс
    func chooseImagePicker(source: UIImagePickerController.SourceType){
    //выполним проверку на доступность выбора источника изображений
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            //позволим пользователю редактировать выбранное изображения перед тем как применить изменения
            imagePicker.allowsEditing = true
            //определяем тип источника для выбранного изображения
            imagePicker.sourceType = source
            
            present(imagePicker, animated: true)
        }
    }
    
    //для того чтобы присвоить выбранное изображение лейблу необходимо реализовать протокол UIImagePickerControllerDelegate
    //данный протокол содержит пару методов один из которых didFinishPickingMediaWithInfo info который сообщает делегату данного протокола о том что выбран  статичный фрагмент видео или изображения
    //также данный протокол содержит структуру UIImagePickerController.InfoKey которая содержит набор ключей определяющих тип контента
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImage.image =  info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
