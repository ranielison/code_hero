# CodeHero Objective 📱

Aplicativo de busca e exibição de heróis da Marvel.

## Pre-requisitos 📐

| Tecnologia | Versão recomendada | Guia de instalação                                                    |
| ---------- | ------------------ | --------------------------------------------------------------------- |
| Flutter    | v3.16.9            | [Flutter Official Docs](https://flutter.dev/docs/get-started/install) |
| Dart       | v3.2.6             | Instalado automaticamente com o Flutter                               |

## Vamos começar 🚀
- Crie um arquivo chamado .env na raiz do projeto e insira as informações da sua public key e private key, que podem ser encontradas na sua conta da [API da Marvel](https://developer.marvel.com/) use o arquivo .env-example como base para preencher as variváveis

Rode os comandos abaixo.

- `flutter pub get` para instalar as dependências.

- `flutter pub run build_runner build --delete-conflicting-outputs` para gerar os mock files.

- `flutter test` para rodar os testes (Opcional, apenas se quiser rodar os testes).

- `flutter run` com um dispositivo conectado, para rodar o projeto, esse passo também pode ser feito a partir do VSCode, ou outra IDE.

## Telas do app

O App Apresenta 3 telas, são elas:

##### Splash Screen

Tela de apresentação do app

<img src="/assets/screenshots/splash.png?raw=true" alt="Splash" width="200" height="400" />

##### Home

Tela com a listagem dos héróis, campo de busca e paginação

###### Visão Mobile
  <img src="/assets/screenshots/home.png?raw=true" alt="Home" />
  <img src="/assets/screenshots/home_grid.png?raw=true" alt="HomeGrid" />


###### Visão Web
<img src="/assets/screenshots/home_web.png?raw=true" alt="HomeWeb" />

##### Detalhes

Detalhes de um herói específico

###### Visão Mobile
  <img src="/assets/screenshots/details.png?raw=true" alt="Details" />


###### Visão Web
<img src="/assets/screenshots/details_web.png?raw=true" alt="DetailsWeb" />


## Comportamentos

###### Carregamento do app

Ao abrir o app uma tela temática da Marvel é exibida e após 2 segundos o app redireciona para tela home, onde há o carregamento dos primeiros resultados.

<img src="/assets/screenshots/splash.gif?raw=true" alt="ViewSelector" />

###### Modo de visualização dos itens

Foi implementado na versão mobile uma alternativa para dispor os itens na tela, os mesmos podem ser vistos em forma de lista ou de grid, bastando selecionar a opção desejada no componente no final da tela.

<img src="/assets/screenshots/view_selector.gif?raw=true" alt="ViewSelector" />

###### Paginação
A Paginação foi implementada de modo a exibir apenas 4 itens por vez, onde ao final da tela é possível está avançando, retrocedendo ou selecionando diretamente uma das páginas exibidas. Caso os resultados cheguem ao fim, a página fica indisponível para seleção.

<img src="/assets/screenshots/pagination.gif?raw=true" alt="Pagination" />


###### Busca
O Aplicativo permite a busca de heróis por nome, a busca retorna os resultados encontrados onde o termo buscado coincide com o inicio do nome do herói, quando os resultados são exibidos a paginção segue a mesma lógica trazendo sempre resultados correspondentes ao termo buscado.

<img src="/assets/screenshots/search.gif?raw=true" alt="Search" />

###### Detalhes do heróis
Ao clicar sobre um herói, tanto na versão mobile quanto na web, uma página de detalhes é aberta contendo todas as informações do herói, uma vez que na tela inicial as informações são simplificadas, na versão mobile apenas foto e nome, na versão web apresenta algumas informações de Séries e Eventos, mas limitados a 3 itens por herói. Sendo assi, as informações completas podem ser acessadas pela tela de detalhes.

<img src="/assets/screenshots/hero_details.gif?raw=true" alt="Search" />

## Responsividade
O app foi projetado para rodar tanto na web quanto no mobile, é possível ver a adaptação da tela home ao mudar o tamanho da tela, no caso da listagem de herois é usado um componente diferente para exibir os dados quando a tela é maior, possibilitando assim a visão de mais dados, na visão mobile uma versão mais simples é utilizada para melhorar a usabilidade. 

<img src="/assets/screenshots/responsivity.gif?raw=true" alt="Search" />

## Estrutura de pastas do projeto

O aplicativo segue os padrões da Clean Architecture.

A Aplicação é dividida em camadas, onde cada camada contem uma responsabilidade.

Temos uma pasta Core onde ficam arquivos de uso geral da aplicação e em seguida uma pasta para cada camada.

Na camada Data ficam os **datasources**, **models** e as implementações dos repositórios.

Na camada Domain ficam as **entities**, os **usecases** e as as interfaces dos repositórios.

Na camada Presentation fica a parte das interfaces das **telas**, onde pra cada tela ou módulo tem uma pasta e cada uma dessas sendo dividida em **bloc**, **pages** e **widgets**.

### Core/api

Cliente HTTP customizado, faz as chamadas à API. Usa configurações básicas para fazer as requisições: BaseURL, Headers, Authentication etc.

### Core/config

Arquivos de configurações do projeto e variáveis de ambiente

### Core/di

Configurações a respeito da injeção de dependências

### Core/error

Exceções customizadas que estendem a classe Exception do próprio Flutter.

### Core/routes

Definição e configuração das rotas da aplicação.

### Core/theme

Cores e estilos de texto padrões da aplicação.

### Core/usecases

Classe abstrata que define como um use case deve ser .

### Core/utils

Variáveis constantes usadas na aplicação.

### Core/widgets

Widgets que são usados em mais de uma **feature**, como botões, caixas de diálogo etc.

### Data/datasource

Uma fonte de dados é um componente responsável por prover acesso aos dados necessários para a aplicação. Ele pode estar ligado a uma base de dados, arquivos, APIs, ou outras formas de armazenamento de informações.

Na arquitetura limpa, é importante que os data sources sejam isolados do restante da aplicação, para garantir a separação de preocupações e permitir a fácil substituição ou alteração da fonte de dados sem afetar o restante do sistema. Além disso, eles devem ser implementados através de interfaces, para que o uso dos dados possa ser abstraído e desacoplado da sua origem.

### Data/models

Os modelos são representações das entidades da aplicação. Além dos atributos, podem conter os transformadores `fromJson` e `toJson` que mapeiam os dados de JSON para mapas do Dart.

### Data/repository

O repositório é um padrão de design que encapsula a lógica de acesso a dados e oferece uma interface para as camadas superiores da aplicação. Ele utiliza a fonte de dados para obter os dados necessários, abstraindo as operações de persistência e recuperação de objetos de domínio. Isso torna o sistema mais modular e flexível, permitindo a fácil substituição ou extensão da lógica de acesso a dados, e promovendo a reutilização de código e a testabilidade do sistema.

### Domain/usecases

Os casos de uso representam as funcionalidades ou requisitos de negócio da aplicação. Eles definem as ações que o usuário pode realizar no sistema e os resultados esperados de cada ação. Em outras palavras, são os cenários de uso que descrevem como o usuário interage com a aplicação para atingir seus objetivos.

### Domain/entities

Representam as entidades da aplicação na sua mais pura forma possível. Diferente dos modelos, as entities possuem apenas atributos.

### Domain/repositories

Aqui são definidas as interfaces do repositório de dados. São abstrações que definem conjuntos de métodos para acesso e manipulação de dados em um repositório de dados específico. Ela é importante na arquitetura limpa porque permite que a camada de aplicação trabalhe com objetos de domínio sem se preocupar com a forma como os dados são armazenados ou recuperados, promovendo modularidade, flexibilidade e testabilidade da aplicação. A interface é implementada como uma API que define um conjunto de métodos para as operações de persistência de dados, e a implementação concreta do repositório é injetada na camada de aplicação durante a configuração da aplicação.

### Presentation/bloc

O BLoC é uma classe que contém a lógica de negócios da aplicação e é responsável por gerenciar o estado da mesma. Ele recebe entradas da interface do usuário (eventos), processa essas entradas e emite saídas (estados) para a interface do usuário. A comunicação entre a interface do usuário e o BLoC é feita por meio de fluxos (streams) e escutas (listeners), que permitem que as mudanças de estado sejam refletidas na interface do usuário.

### Presentation/pages

Aqui ficam as páginas da aplicação. Geralmente cada página implementa uma **feature**, mas pode implementar mais de uma em casos específicos. O conteúdo da página é controlado pelo BLoC responsável por gerenciar seu estado.

### Presentation/widgets

Aqui ficam os **widgets** ou componentes que são utilizados na aplicação. É uma boa prática separar trechos de códigos que representam um componente, que se repete dentro da página, em um arquivo separado, e chamá-lo na página principal. Isso melhora a legibilidade do código, reduzindo a redundância.

## API Utilizada

Para o desenvolvimento desta aplicação, foi utilizada a api oficial [MarvelAPi](https://developer.marvel.com/)