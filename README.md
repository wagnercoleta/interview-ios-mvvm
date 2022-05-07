# interview-ios

## Aviso aos candidatos participando do nosso processo: Faremos um Pair Programming na hora da entrevista. Se atente aos seguintes pontos:

- 🖥 Esteja com sua máquina e seu Xcode funcionando normalmente;
- ✏️ Se possível, clone ou baixe o projeto. Sinta-se à vontade para executar e estudar o projeto de antemão;
- 🙏🏻 Caso realize alguma alteração, favor revertê-la antes da entrevista;
- 😁 Esteja bem hidratado e aproveite, esperamos que você goste de programar conosco!

------------------------------------------------------------------------------------------------------------------------
**ATENÇÃO**: Este projeto é uma cópia do "PicPay / interview-ios" apenas com objetivo de aprendizagem/estudos pessoais na realização do teste.

Fonte: https://github.com/PicPay/interview-ios

**Abaixo, descrevo as alterações no projeto para conseguir refatorar, remover responsabilidades e não travar a interface.**

## Alterações no projeto para separação das responsabilidades:

## 01 - Classes compartilhadas (_shared)

- Criação de classes compartilhadas no projeto com objetivo de refatorar o código e facilitar a separação das responsabilidades:

  - **HttpError**: Enumerado para tratamento de erros Http.
  - **HttpClient**: Protocolo com objetivo de abstração para chamadas Http da aplicação e implementação do adapter de chamadas Http.
  - **SessionAdapter**: Classe adapter que implementa o protocolo HttpClient para requisições Http na aplicação.
  - **NetworkManagerProtocol**: Protocolo para classe de gerenciamento de redes;
  - **NetworkManager**: Classe de gerenciamento de rede para transformar os dados recebidos via httpClient em objetos concretos via generics;
  - **UrlProtocolStub**: Mock de Classe de testes para interceptar chamadas de requisição e possibilitar testar classes de chamadas Http na aplicação.
  - **SessionAdapterTests**: Classe de testes (TU) para classe SessionAdapter.
  - **Observable**: Classe utlizada para realizar o bind entre a View e ViewModel quando existir uma alteração de propriedade da ViewModel e a View precisar ser notificada para atualização. 
  - **AlertView**: Protocolo com objetivo de notificar a ViewController através da View e/u ViewModel para exibição de mensagens com alerts e evitar acoplamento.

## 02 - Serviço (HTTP)

- **ListContactsServices**: Restruturação da classe de serviço para utilizar o network/protocolo responsável por chamadas de rede da aplicação. Com essa restruturação, a responsabilidade de chamadas de rede foi delegada ao protocolo (NetworkManagerProtocol) repassado no construtor do serviço.
- **ListContactsServicesTests**: Classe de testes (TU) para classe ListContactsServices.
- **HttpClientMock**: Classe de mock para possibilitar a criação de testes unitários ao utilizar o protocolo HttpClient.

## 03 - ViewModel

- **ListContactsViewModel**: Restruturação da classe de ViewModel de contatos da aplicação, permitindo apenas responsabilidade de carregar os dados (via chamada do serviço injetado) e seleção de contatos através da classe "UserIdsLegacy" e delegando a exibição para a View pelo protocolo "AlertView".
- **ListContactsViewModelTests**: Classe de testes (TU) para classe ListContactsViewModel.
- **AlertViewMock**: Classe de mock para possibilitar a criação de testes unitários ao utilizar o protocolo AlertView.

## 04 - View

A camada de View utilizava da UI Thread (Main) para realizar a carga dos dados e imagens, isso deixava a aplicação mais lenta e travando. Com a restruturação e separação das responsabilidades descritas acima, foi possível carregar os dados e imagens em outras Threads, possibilitando um carregamento mais rápido e interface sem travamentos.

- **ContactView**: Componente "UIView" para facilitar a reutilização dessa mesma view em outros componentes futuros (por exemplo: UICollectionView). Adicionado o componente "UIActivityIndicatorView" sobre o componente de imagem, parar indicar o carregamento em paralelo da imagem em outra Thread. Outro ajuste nessa classe, foi a inclusão do método "setup (contact: Contact)", utilizado para configurar a célula e carregar a imagem utilizando do serviço de chamada HTTP (SessionAdapter). 
- **ContactCell**: Componente "UITableViewCell" criado para adicionar a view de exibição dos dados (ContactView).
- **ListContactsView**: Componente "UIView" para facilitar a reutilização dessa mesma view em outras telas da aplicação.
- **ListContactsViewController**: Na classe de controller, removemos toda responsabilidade a mais dela e delegamos a ViewModel (ListContactsViewModel) e View (ListContacsView). Deixamos com ela apenas a função de "passagem"das informações (para View e ViewModel) e extendemos o protocolo "AlertView", para que essas camadas possam enviar os alertas para a ViewController poder exibir ao usuário.

## 05 - SceneDelegate

- Instância de Serviços, View, ViewModel e injeção de dependências via construtor das classes.
