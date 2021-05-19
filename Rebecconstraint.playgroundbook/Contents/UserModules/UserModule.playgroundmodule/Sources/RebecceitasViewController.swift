
import UIKit

/*
 Essa classe é um filho de UIViewController, ou seja ela herda todas as capacidades de uma UIViewController.
 Além disso essa classe tambem implementa um protocolo ou 'protocol', protocolo são tipos contratos com uma lista de métodos que a classe que o implementa deve ter, no caso o protocolo que estamos implementando é o 'UITableViewDataSource' ele tem duas funções que devem ser implementadas obrigatoriamente, elas são:
 - tableView(_ tableView:, numberOfRowsInSection section:) -> Int
 - tableView(_ tableView:, cellForRowAt indexPath:) -> UITableViewCell
 
 Mais detalhes sobre essa funções estão encima dela no código abaixo.
 Para mais informação sobre herança e protocolos de uma olhada nos links abaixo:
 
 https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html
 https://docs.swift.org/swift-book/LanguageGuide/Protocols.html
 */
public class RebecceitasViewController: UIViewController, UITableViewDataSource {
    
    /*
     Declaração de componentes visuais.
     
     Uma lista dos diversos componentes do UIKit podem ser vistos no human interface guidelines.
     https://developer.apple.com/design/human-interface-guidelines/ios/overview/interface-essentials/
     */
    
    //View customizada do Avatar, foi feita para que a foto não saisse do do circulo que a rodeia.
    private let avatar: AvatarView
    private let titleLabel: UILabel
    private let addField: UITextField
    private let addButton: UIButton
    //Essa View provavelmente é nova para você. Ela é uma TableView e é um tipo de View responsável por mostrar listas, como a lista de receita que estamos fazendo.
    private let recipeTable: UITableView
    private let totalLabel: UILabel
    
    //É aqui que estamos guardando as receitas que irão aparecer na lista, essa é uma das formas mais simples de guardar um elemento.
    private var recipes: [String]
    
    /*
     Nesse Init estamos dando valor a todos os atributos que declaramos lá em cima isso é equivalente a dar valor e atribuir lá em cima direto mas acho mais bonitos dessa forma =D
     */
    public init() {
        avatar = AvatarView(avatar: #imageLiteral(resourceName: "becca.png"))
        /*
         Você pode está se perguntando o que é esse 'frame: .zero' em todos esses inicializadores, uma UIView quando é criada recebe como parâmetro um frame que é o tamanho e a posição em coordenadas em relação a UIView pai, como iremos usar constraints para definir o tamanho da e posição de todas essa UIViews um atalho chamado .zero é passado como parâmetro e ele significa uma variavel do tipo 'CGRect' zerada.
         Para mais informações sobre o frame aqui esta o link da documentação sobre o assunto
         https://developer.apple.com/documentation/uikit/uiview/1622621-frame
         */
        titleLabel = UILabel(frame: .zero)
        addField = UITextField(frame: .zero)
        addButton = UIButton(frame: .zero)
        recipeTable = UITableView(frame: .zero, style: .insetGrouped)
        totalLabel = UILabel(frame: .zero)
        recipes = ["Rebeccamarão", "Rebeccaramelo", "Rebeccastanha"]
        /*
         Esse é o init da classe mãe no caso UIViewController que deve ser chamado quando um init customizado é criado, essas propriedades fazem mais sentido no contexto de um app principalmente feito com Storyboard, o que é Storyboard? Bem, isso são cenas dos próximos capítulos.
         */
        super.init(nibName: nil, bundle: nil)
    }

    /*
     Isso é um init obrigatório que deve ser criado toda vez que um init novo é criado para uma UIViewController, isso faz mais sentido no contexto de Apps então o significado disso são cenas dos próximos capítulos.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     Esse é o viewDidLoad é um método do ciclo de vida da UIViewController, ele é chamado quando a view da UIViewController é carregada; esse método é um excelente lugar para você colocar seu código de configuração inclusive a configuração que é tema dessa aula, as constraints.
     */
    public override func viewDidLoad() {
        /* 
         Esse .systemBackground é uma System Color e o que são elas, são cores disponibilizadas pela Apple que se adaptam ao light e dark mode, para mais informações olhe esse link do Human Interface Guidelines.
         https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
         */
        view.backgroundColor = .systemBackground
        
            // Nas funções abaixo são adicionados as views que declaramos lá em cima como filhas da view principal da nossa ViewController
        view.addSubview(avatar)
        view.addSubview(titleLabel)
        view.addSubview(addField)
        view.addSubview(addButton)
        view.addSubview(recipeTable)
        view.addSubview(totalLabel)
        
            //Nessa função todas as contraints irão ser adicionadas
        addConstraints()
        
            //Nessa função todas as configurações dos nossos componentes serão feitos
        configureAvatarStyle()
        configureTitleStyle()
        configureAddFieldStyle()
        configureAddButtonStyle()
        configureRecipeTable()
        configureTotalLabelStyle()
        addUserInteraction()
    }
    
    private func addConstraints() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let avatarConstraints: [NSLayoutConstraint] = [
            avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 240),
            avatar.widthAnchor.constraint(equalToConstant: 240)
        ]
        
        NSLayoutConstraint.activate(avatarConstraints)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        
        addField.translatesAutoresizingMaskIntoConstraints = false
        
        let addFieldConstraint: [NSLayoutConstraint] = [
            addField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 64),
            addField.leadingAnchor.constraint(equalTo: recipeTable.leadingAnchor, constant: 15),
            addField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            addField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(addFieldConstraint)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let addButtonConstraint: [NSLayoutConstraint] = [
            addButton.topAnchor.constraint(equalTo: addField.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: addField.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: addField.trailingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: recipeTable.trailingAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(addButtonConstraint)
        
        recipeTable.translatesAutoresizingMaskIntoConstraints = false
        
        let recipeTableConstraint: [NSLayoutConstraint] = [
            recipeTable.topAnchor.constraint(equalTo: addField.bottomAnchor, constant: 64),
            recipeTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            recipeTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64)
        ]
        
        NSLayoutConstraint.activate(recipeTableConstraint)
        
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let totalLabelConstraints: [NSLayoutConstraint] = [
            totalLabel.topAnchor.constraint(equalTo: recipeTable.bottomAnchor, constant: 16),
            totalLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(totalLabelConstraints)
    }
    
    private func configureAvatarStyle() {
        //Aqui é dado um cornerRadius de 120 que é metade da largura da View, como ela é quadrada 
        avatar.layer.cornerRadius = 120
        /*
         As configurações abaixo são usadas para dar um efeito de sombra a View, isso é feito para dar uma percepção maior de separação maior aos componentes em relação ao fundo
         */
            //Nessa linha é dada a cor da sombra
        avatar.layer.shadowColor = UIColor.black.cgColor
            //Nessa é dada a opacidade da sombra
        avatar.layer.shadowOpacity = 0.6
            //Aqui a sombra é empurrada 4 pontos para direita e para baixo
        avatar.layer.shadowOffset = .init(width: 4, height: 4)
            //Aqui é dado um raio para a sombra de 6 pontos
        avatar.layer.shadowRadius = 6
    }
    
    private func configureTitleStyle() {
        //Testo do titulo
        titleLabel.text = "Rebecceitas"
            // Alinhamento do titulo
        titleLabel.textAlignment = .center
            // Aqui é dado uma font bold com a fonte padrão do sistema de tamanho 60
        titleLabel.font = .boldSystemFont(ofSize: 60)
            // Isso é uma propriedade para que o texto possa mudar o tamanho da fonte de acordo com a largura da tela, isso só funciona se você usar Constraints das bordas da View, como top, bottom, left, leading, right, trailing, constraints como centerY, centerX não permitem essas configurações pois a view pode crescer inderteminadamente de acordo com o tamanho do texto.
        titleLabel.adjustsFontSizeToFitWidth = true
            //Essa é uma cor padrão para textos, que deixa branco para o darkMode e preto para o lightMode
        titleLabel.textColor = .label
    }
    
    private func configureAddFieldStyle() {
        // Aqui é configurado o texto de placeholder, esse é o texto que aparece quando a view esta vazia.
        addField.placeholder = "Digite aqui sua rebecceita"
        addField.font = .systemFont(ofSize: 20)
        addField.layer.cornerRadius = 10
            // Aqui é criado uma UIView vazia com largura 15, isso é usado para dar aquela pequena margem do texto com a borda do campo de texto
        addField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.addField.frame.height))
            // Aqui é configurado que essa pequena margem sempre apareça
        addField.leftViewMode = .always
        addField.backgroundColor = .secondarySystemBackground
        addField.layer.shadowColor = UIColor.black.cgColor
        addField.layer.shadowOpacity = 0.2
        addField.layer.shadowOffset = .init(width: 4, height: 4)
        addField.layer.shadowRadius = 6
    }
    
    private func configureAddButtonStyle() {
        /*
         UIButtons possuem states, eles são nada mais que o estado em que o botão está como .normal que é o estado quando nada esta acontecendo ou highlighted que é quando o usuario está com o dedo no botão
         */
        addButton.setTitle("Adicionar", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 15
        addButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        addButton.backgroundColor = .systemBlue
        
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOpacity = 0.2
        addButton.layer.shadowOffset = .init(width: 4, height: 4)
        addButton.layer.shadowRadius = 6
        
    }
    
    private func configureRecipeTable() {
        /*
         Toda TableView precisa de um DataSource, ele é responsavel por fornecer os dados para a TableView mostrar no caso como estamos implementando o protocolo UITableViewDataSource esse dataSource é self, além disso toda TableView tem um tipo de Célula no caso é o tipo padrão UITableViewCell que dispõe de um titulo, subtitulo e imagem, além disso ele precisa de um identificador no caso o CellReuseIdentifier, ele é uma String qualquer e tem um papel primordial para o funcionamento de uma TableView
         
         Quando as TableView possui muitos elementos e precisa ser scrollada seria muito custoso computacionalmente criar uma célula nova toda vez, isso significaria que a tela iria travar com tempo devido a alta demanda de processo, e pra isso existe o reuso e o CellReuseIdentifier ele é usado para identificar os tipos de células diferentes para quando uma célula saia de tela, ela pode ser reutilizada pra criar uma nova.
         */
        recipeTable.dataSource = self
        recipeTable.register(UITableViewCell.self, forCellReuseIdentifier: "recipes")
        recipeTable.backgroundColor = .systemBackground
    }
    
    private func configureTotalLabelStyle() {
        setTotalRecipesNumber(to: recipes.count)
        totalLabel.textColor = .label
        totalLabel.font = .systemFont(ofSize: 18)
        
    }
    
    private func setTotalRecipesNumber(to number: Int) {
        totalLabel.text = "Total of recipes: \(number)"
        totalLabel.textAlignment = .center
    }
    
    private func addUserInteraction() {
        /*
         Aqui são colocados seletores para ações do botão de adicionar o primeiro é pra quando um botão é pressionado e depois solto e ele é o responsavel pela ação de pegar o texto do TextField e adicionar a lista
         */
        addButton.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonIsBeingPressed), for: .touchDown)
    }
    
    private func addRecipe(_ recipe: String) {
        /*
         guard é um tipo de verificação de guarda ou segurança, caso algumas das checagens der false ele vai cair no else que sempre tem que ter um retorno, é um tipo de verificação legal de fazer em alguns casos pois ela mantem o código do caminho esperado dentro do corpo principal da função e os erros dentro dos elses
         */
        guard recipe != "" else { return }
        guard !recipe.starts(with: "Rebe"), !recipe.starts(with: "rebe") else {
            updateUIWith(data: recipe)
            addField.text = ""
            return
        }
        var formatedRecipe = recipe.lowercased()
        
        if formatedRecipe.starts(with: "c") {
            formatedRecipe = "Rebec\(formatedRecipe)"
        } else {
            formatedRecipe = "Rebe\(formatedRecipe)"
        }
        
        updateUIWith(data: formatedRecipe)
        addField.text = ""
    }
    
    private func updateUIWith(data: String) {
        recipes.append(data)
        setTotalRecipesNumber(to: recipes.count)
        //A função reloadData() é responsável por fazer a tableView recarregar os dados e mostrar a versão mais atualizada, assim adicionando na lista o novo item criado. 
        recipeTable.reloadData()
    }
    
    @objc
    private func addButtonTouchUpInside(sender: UIButton) {
        sender.backgroundColor = .systemBlue
        guard let recipe = addField.text else { return }
        addRecipe(recipe)
        
    }
    
    @objc
    private func addButtonIsBeingPressed(sender: UIButton) {
        guard let blue = UIColor.systemBlue.cgColor.components else { return 
        }
        /*
         Esse código é responsavel por criar um tom de azul mais escuro para quando o botão estiver sendo pressionado.
         para mais informações de como fazer isso olhe a documentação de UIColor e pesquise sobre
         
         https://developer.apple.com/documentation/uikit/uicolor
         */
        let darkerBlue = UIColor(red: blue[0] - 0.07, green: blue[1] - 0.07, blue: blue[2] - 0.07, alpha: 1)
        
        sender.backgroundColor = darkerBlue
    }
    
    /*
     Essas são as funções que um objeto que implementa o protocolo UITableViewDataSource devem ter elas são responsáveis por dizer quantas celulas devem ter e como reutilizar as celulas antigas para tornar elas em células novas
     */
    /*
     Essa função é responsável por dar a quantidade células que devem aparecer no caso a quantidade é o número de elementos que o Array 'recipes' possuem.
     */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    /*
     Essa função é rresponsável por configurar cada célula para que ela possa aparecer em tela.
     */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Aqui ele pega a célula adequada para o reuso de acordo com o identificador e a posição dela na lista
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipes", for: indexPath)
        
            // Aqui abaixo é configurado os conteúdos da célula, como a cor de fundo, o texto e sua fonte.
        cell.backgroundColor = .secondarySystemBackground
        
        if let textLabel = cell.textLabel {
            textLabel.font = .systemFont(ofSize: 20)
            textLabel.text = recipes[indexPath.row]
        }
        
        return cell
    }
}
