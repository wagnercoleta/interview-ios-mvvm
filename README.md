# interview-ios

## Aviso aos candidatos participando do nosso processo: Faremos um Pair Programming na hora da entrevista. Se atente aos seguintes pontos:

- 🖥 Esteja com sua máquina e seu Xcode funcionando normalmente;
- ✏️ Se possível, clone ou baixe o projeto. Sinta-se à vontade para executar e estudar o projeto de antemão;
- 🙏🏻 Caso realize alguma alteração, favor revertê-la antes da entrevista;
- 😁 Esteja bem hidratado e aproveite, esperamos que você goste de programar conosco!

------------

## Alterações no projeto para separação das responsabilidades:

## 001

- Criação de classes compartilhadas no projeto:
  - Interview\Scenes\_shared\Infra\HttpError: Enumerado para tratamento de erros Http.
  - Interview\Scenes\_shared\Infra\HttpClient: Protocolo com objetivo de abstração para chamadas Http da aplicação e implementação do adapter de chamadas Http.
  - Interview\Scenes\_shared\Infra\SessionAdapter: Classe adapter que implementa o protocolo HttpClient para requisições Http na aplicação.
  - InterviewTests\Scenes\_shared\Infra\UrlProtocolStub: Mock de Classe de testes para interceptar chamadas de requisição e possibilitar testar classes de chamadas Http na aplicação.
  - InterviewTests\Scenes\_shared\Infra\SessionAdapterTests: Classe de testes (TU) para classe SessionAdapter.
  - InterviewTests\Scenes\_shared\ViewModel\Observable: Classe utlizada para realizar o bind entre a View e ViewModel quando existir uma alteração de propriedade da ViewModel e a View precisar ser notificada para atualização. 
