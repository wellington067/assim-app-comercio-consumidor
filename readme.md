# Vida Agroecológica - Aplicativo do Consumidor

<p align="center">
  <table>
    <tr>
      <td><img src="lib/assets/images/logoAssim.png" alt="Logo Vida Agroecológica" width="200"/></td>
      <td><img src="lib/assets/images/logo_lmts.png" alt="Logo LMTS" width="200"/></td>
      <td><img src="lib/assets/images/ufape-logo.png" alt="Logo UFAPE" width="200"/></td>
    </tr>
  </table>
</p>

[![Versão Flutter](https://img.shields.io/badge/Flutter->=2.17.6-blue.svg)](https://flutter.dev)
[![Versão](https://img.shields.io/badge/versão-1.1.0-green.svg)](VERSION)
[![Estilo: Flutter](https://img.shields.io/badge/estilo-flutter_lints-blue)](https://pub.dev/packages/flutter_lints)

## 📱 Sobre o Projeto

O **Vida Agroecológica** é uma plataforma de e-commerce móvel que conecta produtores rurais da Associação de Produtores e Moradores Agroecológicos do Imbé, Marrecos e Sítios Vizinhos (ASSIM) diretamente aos consumidores urbanos de Bonito-PE e região. Desenvolvido em Flutter, este aplicativo visa fortalecer a agricultura familiar, promover práticas agroecológicas e estabelecer uma relação de confiança entre campo e cidade.

Este projeto é fruto de uma colaboração entre a **Universidade Federal do Agreste de Pernambuco (UFAPE)**, através do **Laboratório Multidisciplinar de Tecnologias Sociais (LMTS)**, e a comunidade agrícola local, buscando soluções tecnológicas para desafios reais de comercialização.

## 🌱 Contexto Social

O aplicativo nasceu da necessidade de consolidar espaços de produção, comercialização e consumo fundamentados na agroecologia, comércio justo e consumo consciente. Tem como objetivos principais:

- Potencializar as práticas de comercialização da ASSIM
- Apoiar a participação de mulheres e jovens agricultores na comercialização
- Fortalecer a relação entre consumidores e produtores agroecológicos
- Simplificar o processo de vendas e aumentar a geração de renda dos produtores

## 🛒 Funcionalidades Principais

### Para o Consumidor
- **Exploração de Produtos**: Navegue pelo catálogo completo de produtos agroecológicos
- **Gerenciamento de Carrinho**: Adicione, remova e ajuste quantidades de produtos
- **Acompanhamento de Pedidos**: Visualize status e histórico de pedidos em tempo real
- **Perfil Personalizado**: Gerencie dados pessoais e preferências
- **Favoritos**: Salve produtos preferidos para compras futuras
- **Avaliações**: Compartilhe sua experiência avaliando produtos e produtores
- **Modo Offline**: Acesse informações básicas mesmo sem conexão com internet

### Recursos Técnicos
- **Autenticação Segura**: Sistema de login e cadastro com proteção de dados
- **Cache de Imagens**: Carregamento otimizado e persistência local
- **Notificações Locais**: Alertas sobre atualizações de pedidos
- **Download de Documentos**: Visualização e download de recibos em PDF
- **Design Responsivo**: Adaptação a diferentes tamanhos de tela
- **Multilíngue**: Suporte a múltiplos idiomas (em desenvolvimento)

## 💻 Tecnologias Utilizadas

### Front-end
- **Framework**: Flutter >=2.17.6
- **Linguagem**: Dart (com null safety)
- **Gerenciamento de Estado**: Provider e GetX
- **Interface**: Material Design com componentes personalizados

### Armazenamento e Persistência
- Shared Preferences
- Flutter Secure Storage
- Path Provider

### Networking e API
- Dio e HTTP para requisições
- RESTful API
- JSON Serialization

### Componentes Visuais
- Google Fonts
- Flutter SVG
- Animações Lottie
- Photo View (zoom de imagens)
- Skeleton Loaders

## 🔧 Instalação e Uso

### Requisitos
- Flutter SDK >=2.17.6
- Dart SDK compatível
- Android: API level 23+ (Android 6.0+)
- iOS: iOS 12.0+

### Passos para Instalação

```bash
# Clone o repositório
git clone https://github.com/douglaskks/assim-app-comercio-consumidor.git

# Entre no diretório
cd assim-app-comercio-consumidor

# Instale as dependências
flutter pub get

# Execute o aplicativo
flutter run
```

### Build para Produção

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📂 Estrutura do Projeto

```
lib/
├── assets/              # Recursos estáticos (imagens, fontes)
├── components/          # Widgets reutilizáveis
├── config/              # Configurações do aplicativo
├── models/              # Modelos de dados
├── providers/           # Gerenciamento de estado
├── screens/             # Telas do aplicativo
│   ├── auth/            # Autenticação
│   ├── banca/           # Catálogo de produtos
│   ├── carrousel/       # Carrossel de destaques
│   ├── cesta/           # Carrinho de compras
│   ├── favorito/        # Produtos favoritos
│   ├── pedidos/         # Acompanhamento de pedidos
│   ├── produto/         # Detalhes de produto
│   └── profile/         # Perfil do usuário
├── services/            # Serviços de API e dados
├── shared/              # Recursos compartilhados
│   ├── constants/       # Constantes da aplicação
│   ├── utils/           # Funções utilitárias
│   └── validators/      # Validadores de formulários
└── main.dart            # Ponto de entrada do aplicativo
```

## 🤝 Como Contribuir

1. Faça um fork do repositório
2. Crie sua branch de feature (`git checkout -b feature/nova-funcionalidade`)
3. Faça commit das suas alterações (`git commit -m 'Adiciona nova funcionalidade'`)
4. Envie para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📊 Estado Atual

Este projeto está em desenvolvimento ativo como parte de uma iniciativa acadêmica e de extensão. A versão atual (1.1.0) implementa as funcionalidades básicas do e-commerce com foco no consumidor final.

## 📞 Contato e Suporte

- **Desenvolvido por**: LMTS - Laboratório Multidisciplinar de Tecnologias Sociais (UFAPE)
- **E-mail**: [lmts@ufape.edu.br](mailto:lmts@ufape.edu.br)
- **Universidade**: [Universidade Federal do Agreste de Pernambuco](https://ufape.edu.br/)

## 📄 Licença

Este projeto está em fase de registro de propriedade intelectual.

---

<p align="center">
Desenvolvido com ❤️ pelo LMTS (Laboratório Multidisciplinar de Tecnologias Sociais)
</p>