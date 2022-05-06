import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

/*
     Lucas e Helton - Compartilhamento de conhecimento via call
     -------------------------------------------------------------
     
        * Arquitetura de apresentação *

          MVVM - >
          View -> Regras Layout
          ViewController -> Camada de passagem.
          ViewModel -> Regras de negocio
          
          * Modificadores de acesso. *
          
          Open -> Fora do modulo acessado, ele pode ser sobescrevido
          Public -> Fora do modulo acessado
          Internal -> Acessível para todo o projeto. Default
          Private -> Acessivel dentro da classe e também nas extensions
          File private -> Acessivel apenas a classe em que foi criada, não as extensions.
          
          * Injeção de dependência *

          Injeção por construtor -> Injetado no init da classe, para garantir que a classe ja inicie com tudo que precisa para executar suas acoes.
          Injeção por acoplamento -> Injetado por acoplamento no meio do codigo, de forma forte.
          Injeção por parametro -> Injetado passando por parametro em funções.
          
          * Retain LifeCycle *

          weak -> Segura uma referencia de memoria da classe, porém de forma fraca caso retorne e ela nao exista mais não ira acontecer nada.
          unowned -> Quase um forcingWrapping, voce esta garantindo que aquilo existe
          
          * Class Structs *
          
          Class -> Referencia unica em memoria
          Structs -> Referencia multipla em memoria.
          
          * Threads *

          Main -> Thread principal aonde é executado as renderizações visuais, isso significa que caso voce coloque algo na main de forma demorada irá travar visualmente o aplicativo para o usuario, por mais que ele de fato não esteja travado.
          Global -> Thread background, que roda os servicos solicitados fora da vista do usuario.
          
          * Serialização de objeto *

          Codable -> Ele pode ser serializado como json ou como objeto, ele é os dois de baixo
          Encodable -> Transformar em JSON
          Decodable -> Tranformar em Objeto
*/

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

