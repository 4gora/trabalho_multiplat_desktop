import 'package:flutter/material.dart';
import 'tela_inicio.dart';

// a tela de login é como um placeholder, não tem função prática. Apenas clique em continua

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5), // Fundo cinza claro
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white, // Card branco
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 12),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo texto estilizado
              Text(
                'Musicolector',
                style: TextStyle(
                  color: Color(0xff0d4f9f),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 16),
              // Texto sutil
              const Text('Faça seu login', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 16),
              // Campo de login
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Digite seu E-mail ou nome de usuário',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botão continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0d4f9f),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => InicioScreen()),
                    );
                  },
                  child: const Text('CONTINUAR', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              // Linha divisória
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 16,
                      child: const Text('ou', style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),
              // Texto e ícones sociais
              const Text('Conecte-se com sua rede social', style: TextStyle(fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.g_mobiledata, size: 32, color: Colors.black87),
                  SizedBox(width: 16),
                  Icon(Icons.apple, size: 32, color: Colors.black87),
                  SizedBox(width: 16),
                  Icon(Icons.facebook, size: 32, color: Color(0xff1877f3)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
