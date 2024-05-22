import 'package:acai_bank/models/checkLogin.dart';
import 'package:flutter/material.dart';

// Definição da página de login como um widget stateful
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Estado associado à página de login
class _LoginPageState extends State<LoginPage> {
  late Color myColor; // Cor primária utilizada no tema
  late Size mediaSize; // Tamanho da tela
  TextEditingController emailController =
      TextEditingController(); // Controlador para o campo de e-mail
  TextEditingController passwordController =
      TextEditingController(); // Controlador para o campo de senha
  bool rememberUser = false; // Flag para lembrar o usuário

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Falhou"),
          content: Text("Email ou senha incorretos."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor; // Obtém a cor primária do tema
    mediaSize = MediaQuery.of(context).size; // Obtém o tamanho da tela
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.png"), // Imagem de fundo
          fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a tela
          colorFilter: ColorFilter.mode(myColor.withOpacity(0.2),
              BlendMode.dstATop), // Aplica um filtro de cor na imagem
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors
            .transparent, // Fundo transparente para mostrar a imagem de fundo
        body: Stack(
          children: [
            Positioned(top: 80, child: _buildTop()), // Posiciona o topo da tela
            Positioned(
                bottom: 0,
                child: _buildBottom()), // Posiciona a parte inferior da tela
          ],
        ),
      ),
    );
  }

  // Construção do topo da tela
  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance, // Ícone de banco
            size: 50,
            color: Colors.white,
          ),
          Text(
            "AçaiBank",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  // Construção da parte inferior da tela
  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(), // Constrói o formulário de login
        ),
      ),
    );
  }

  // Construção do formulário de login
  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bem Vindo",
          style: TextStyle(
            color: myColor,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildGrey("por favor faça login com suas informações"),
        const SizedBox(height: 60),
        _buildGrey("Email "),
        _buildInputField(emailController), // Campo de entrada para o e-mail
        const SizedBox(height: 40),
        _buildGrey("Senha "),
        _buildInputField(passwordController,
            isPassword: true), // Campo de entrada para a senha
        const SizedBox(height: 20),
        _buildRememberForgot(), // Seção de "lembrar de mim" e "esqueci a senha"
        const SizedBox(height: 20),
        _buildLoginButton(), // Botão de login
        const SizedBox(height: 20),
        _buildOtherLogin(), // Opções de login alternativo
      ],
    );
  }

  // Texto cinza reutilizável
  Widget _buildGrey(String text) {
    return Text(
      text,
      style: TextStyle(color: const Color.fromARGB(255, 59, 58, 58)),
    );
  }

  // Campo de entrada de texto reutilizável
  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? Icon(Icons.remove_red_eye)
            : Icon(Icons.done), // Ícone ao lado do campo de entrada
      ),
      obscureText: isPassword, // Oculta o texto se for um campo de senha
    );
  }

  // Seção de "lembrar de mim" e "esqueci a senha"
  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberUser,
              onChanged: (value) {
                setState(() {
                  rememberUser = value!;
                });
              },
            ),
            _buildGrey("Relembre-me"),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: _buildGrey("Esqueci a minha senha"),
        ),
      ],
    );
  }

  // Botão de login
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        String email = emailController.text;
        String password = passwordController.text;

        bool loginSuccess = await checkLogin(email, password);

        if (loginSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Mostrar diálogo de erro
          showErrorDialog(context);
        }

        // Para fins de depuração
        debugPrint("Email : $email");
        debugPrint("Senha : $password");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }

  // Opções de login alternativo (Facebook, Twitter, Google)
  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGrey("Ou faça login com"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(
                  icon: Image.asset(
                      "assets/images/facebook.png")), // Ícone do Facebook
              Tab(
                  icon: Image.asset(
                      "assets/images/twitter.png")), // Ícone do Twitter
              Tab(
                  icon: Image.asset(
                      "assets/images/google.png")), // Ícone do Google
            ],
          ),
        ],
      ),
    );
  }
}
