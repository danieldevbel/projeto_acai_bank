import 'package:acai_bank/models/checkLogin.dart';
import 'package:flutter/material.dart';

// Tela de login que vai ser um StatefulWidget pra poder mudar de estado
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Aqui tá o estado da tela de login
class _LoginPageState extends State<LoginPage> {
  // Variáveis que vamos usar no layout
  late Color myColor;
  late Size mediaSize;

  // Controladores pros campos de email e senha
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false; // Checkbox pra lembrar do usuário

  // Função pra mostrar um diálogo de erro se o login falhar
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cor personalizada pro fundo
    myColor = Color.fromARGB(255, 70, 11, 70);
    mediaSize = MediaQuery.of(context).size; // Tamanho da tela
    return Container(
      decoration: BoxDecoration(
        color: myColor, // Cor de fundo
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Parte de cima do layout
            Positioned(top: 80, child: _buildTop()),
            // Parte de baixo do layout
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  // Construindo a parte de cima do layout
  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance,
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

  // Construindo a parte de baixo do layout
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
          child: _buildForm(),
        ),
      ),
    );
  }

  // Construindo o formulário de login
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
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGrey("Senha "),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  // Função pra criar textos cinzas
  Widget _buildGrey(String text) {
    return Text(
      text,
      style: TextStyle(color: const Color.fromARGB(255, 59, 58, 58)),
    );
  }

  // Função pra criar os campos de texto
  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  // Função pra criar a linha com o checkbox e o link de esqueci a senha
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

  // Função pra criar o botão de login
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        String email = emailController.text;
        String password = passwordController.text;

        // Chamando a função de login e verificando o retorno
        String? userName = await checkLogin(email, password);

        if (userName != null) {
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: userName,
          );
        } else {
          showErrorDialog(context);
        }

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

  // Função pra criar a opção de login com outras plataformas
  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGrey("Ou faça login com"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/facebook.png")),
              Tab(icon: Image.asset("assets/images/twitter.png")),
              Tab(icon: Image.asset("assets/images/google.png")),
            ],
          ),
        ],
      ),
    );
  }
}
