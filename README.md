# Core-Data

- Framework de Persistencia de dados (guardar os dados e pode ser utilizado quando o usuario executar o app)

Em iOS existem diferentes sistemas de persistencia de dados como:
- NSUserDefaults
- Property Lists
- NSFileManager
- SQLite
- Core Data

Conceitos que estão ligados ao Core Data:

1 - NSManagedObjectModel: representa o MODELO no disco
2 - NSManagedObject: representa um OBJETO UNICO armazenado no Core Data
3 - NSManagedObjectContext: parecido como "espaço de memoria temporal". O XCODE gera automaticamente quando ativamos a opção "Usar Core Data" (fica armazenado no AppleDelegate)
4 - NSEntityDescription: ENTIDADE no Core Data
5 - NSFetchRequest: a classe responsavel de RECUPERAR os dados no Core Data. (fetchRequest  recupera un conjunto de objetos)
6 - extensão .xcdatamodeld  corresponde ao modelo de dados do app. Esde modelo de dados pode criar, modificar e configurar visualmente no proprio Xcode.
