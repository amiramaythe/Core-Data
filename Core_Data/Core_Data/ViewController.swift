//
//  ViewController.swift
//  Core_Data
//
//  Created by Amira Maythe Vasquez on 17/02/2020.
//  Copyright © 2020 desafio. All rights reserved.
//

import UIKit
import CoreData

// O Core Data fornece persistência no disco, o que significa que seus dados estarão acessíveis mesmo após o encerramento do aplicativo ou o desligamento do dispositivo.

//Uma entidade é uma definição de classe no Core Data.
//Um atributo é uma informação anexada a uma entidade.
//Um relacionamento é um link entre várias entidades.
//Um NSManagedObject é uma representação em tempo de execução de uma entidade de Dados Principais

//NSManagedObjectContext para salvar () ou buscar (_ :) dados de e para os Dados Principais.

class ViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    //guardado objetos na entidade pessoa
    var people: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //titulo na barra de navegação
        title = "Lista"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    //recuperar os dados que foram guardados
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //1 managed object context a partir do appDelegate.
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        //2 objeto fetch request para recuperar os nomes das pessoas
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        //3 controlando os erros
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        //atualizando os dados na table
        tableView.reloadData()
    }



    @IBAction func addNames(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Novo nome", message: "Digite um novo nome", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Salvar", style: .default) {
            [unowned self] action in

            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }

            //onde guardamos os dados
            self.save(name: nameToSave)
            self.tableView.reloadData()

        }

        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addTextField()

        alert.addAction(saveAction)
        alert.addAction(cancelarAction)

        present(alert, animated: true)
    }

    //Função que guarda no disco
    func save(name: String) {

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        // 1 recuperando o managed object context a partir do appDelegate.
        let managedContext =
            appDelegate.persistentContainer.viewContext

        // 2 criando um objeto do tipo NSEntityDescription e armazenamos na variavel entity, que representa a entidade Person.
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!

        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)

        // 3 Utilizando KVC para especificar o nome da Person.
        person.setValue(name, forKeyPath: "name")

        // 4  Utilizamos o método save() do managed object context para guardar a pessoa no disco. Como essa operação de guardado pode falhar e dar um erro, realizamos a chamada dentro de um try-catch.
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    //função que retorna o numero de linhas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    //numero de itens na matriz de nomes
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //criando um objeto person que recuperamos do array people
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //Com KVC (utilização de Strings - acessar a propriedade do objeto) obtemos o conteudo do atributo "name" da person e adicionamos na Cell
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }

}


