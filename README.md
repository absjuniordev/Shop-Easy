# ShopEase - A sua Loja Virtual

Este é um protótipo de aplicativo para loja virtual, desenvolvido para plataformas Android e iOS. Com este aplicativo, os usuários podem cadastrar produtos, visualizar, alterar, realizar compras e explorar uma variedade de produtos disponíveis.

## Configuração do Firebase

Para utilizar este aplicativo, é necessário configurar um projeto no Firebase e obter duas informações importantes: a URL do Realtime Database e a API Key.

1. **Criação do Projeto no Firebase:**
   - Acesse o [Console do Firebase](https://console.firebase.google.com/) e crie um novo projeto.
   
2. **Obtenção da URL do Realtime Database:**
   - No menu lateral, vá para a seção "Realtime Database".
   - Copie a URL do seu banco de dados em tempo real.

3. **Obtenção da API Key:**
   - No menu lateral, vá para a seção "Visão Geral do Projeto" > "Configurações do Projeto".
   - Na guia "Geral", copie a chave da API.

## Configuração do Arquivo .env

Após obter a URL do Realtime Database e a API Key, crie um arquivo `.env` na raiz do projeto e insira as seguintes linhas:
```
BASE_URL=https://<NOME_PROJETO>-default-rtdb.firebaseio.com/
API_KEY=Sua_API_Key_Aqui
```
Certifique-se de substituir `<NOME_PROJETO>` pela ID do seu projeto no Firebase e `Sua_API_Key_Aqui` pela chave da API que você obteve.


## Funcionalidades Principais

- **Cadastro de Produtos:** Os usuários podem cadastrar novos produtos na loja virtual, fornecendo informações como nome, descrição, preço e imagem do produto.

- **Visualização de Produtos:** Os produtos cadastrados podem ser visualizados pelos usuários, exibindo detalhes como nome, descrição e preço.

- **Alteração de Produtos:** Os usuários têm a capacidade de alterar as informações de produtos existentes, como nome, descrição, preço e imagem.

- **Realização de Compras:** Os clientes podem selecionar produtos disponíveis para compra e realizar transações de compra dentro do aplicativo.

## Tecnologias Utilizadas

- **Firebase:** O Firebase é utilizado como banco de dados para armazenar e manipular informações dos produtos. A funcionalidade CRUD (Create, Read, Update, Delete) é implementada para gerenciar os dados.

- **Provider:** Para o gerenciamento de estado da aplicação, é utilizado o Provider, uma biblioteca para o Flutter que facilita o compartilhamento de estados entre diferentes partes da aplicação.

- **intl:** Biblioteca para formatação de datas e números.

- **http:** Cliente HTTP para realizar requisições web.

- **page_transition:** Biblioteca para animações de transição entre páginas.

- **flutter_animate:** Pacote para animações em Flutter.

- **shared_preferences** Pacote para armazenamnto de dados no dispositivo.

- **flutter_dotenv:** A biblioteca flutter_dotenv é utilizada para carregar variáveis de ambiente a partir de um arquivo .env. Isso é útil para configurar variáveis sensíveis, como chaves de API, de forma segura.

## Instalação e Execução

1. Clone este repositório em sua máquina local.
2. Certifique-se de ter o Flutter SDK instalado em seu ambiente de desenvolvimento. Para obter instruções sobre como instalar o Flutter, consulte a [documentação oficial do Flutter](https://flutter.dev/docs/get-started/install).
3. Execute o comando `flutter pub get` para instalar todas as dependências do projeto.
4. Sera necesario ter um emulador Android e/ou IOS instalado em sua maquina.
5. Execute o aplicativo em seu emulador ou dispositivo usando o comando `flutter run`.

## Contribuição

Contribuições são bem-vindas! Se você tiver sugestões, correções de bugs ou melhorias para o aplicativo, sinta-se à vontade para abrir uma issue ou enviar uma solicitação de pull request.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE). Sinta-se à vontade para usar, modificar e distribuir este software conforme necessário.