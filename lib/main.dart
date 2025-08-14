import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título do aplicativo na barra de tarefas
      title: 'Contato Direto',
      // Define o tema do aplicativo com cores padrão do WhatsApp
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal, // Cor principal
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // ==============================================
  // AQUI VOCÊ PODE EDITAR OS NÚMEROS E O DEEP LINK
  // ==============================================

  // Os números de telefone do WhatsApp. Substitua '55' pelo código do seu país, se necessário.
  // Certifique-se de que o número está no formato '5531999999999' (código do país + DDD + número).
  final String whatsappComercial = '5531999999999';
  final String whatsappSuporte = '5531988888888';
  final String whatsappFinanceiro = '5531977777777';

  // O deep link para abrir outro aplicativo.
  // Substitua 'outraapp://' pelo esquema do aplicativo que você quer abrir.
  final String appDeepLink = 'outraapp://';

  // ==============================================
  // FIM DA SEÇÃO EDITÁVEL
  // ==============================================

  // Função para abrir o WhatsApp com um número específico
  Future<void> _launchWhatsApp(String phoneNumber) async {
    final String url = 'whatsapp://send?phone=$phoneNumber';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Caso não consiga abrir o WhatsApp, tente abrir a versão web
      final String webUrl = 'https://wa.me/$phoneNumber';
      final Uri webUri = Uri.parse(webUrl);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri);
      } else {
        // Se nenhum dos dois funcionar, mostre um erro
        throw 'Não foi possível abrir o WhatsApp.';
      }
    }
  }

  // Função para abrir um URL (para o deep link)
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Não foi possível abrir o aplicativo ou o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contato Direto'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Botão para o WhatsApp Comercial
              _buildButton(
                context,
                text: 'WhatsApp Comercial',
                icon: Icons.business,
                onPressed: () => _launchWhatsApp(whatsappComercial),
              ),
              const SizedBox(height: 16),

              // Botão para o WhatsApp Suporte Técnico
              _buildButton(
                context,
                text: 'Suporte Técnico',
                icon: Icons.support_agent,
                onPressed: () => _launchWhatsApp(whatsappSuporte),
              ),
              const SizedBox(height: 16),

              // Botão para o WhatsApp Financeiro
              _buildButton(
                context,
                text: 'WhatsApp Financeiro',
                icon: Icons.account_balance,
                onPressed: () => _launchWhatsApp(whatsappFinanceiro),
              ),
              const SizedBox(height: 16),

              // Botão para abrir outro aplicativo via deep link
              _buildButton(
                context,
                text: 'Abrir Outro Aplicativo',
                icon: Icons.open_in_new,
                onPressed: () => _launchUrl(appDeepLink),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget de helper para criar botões com um estilo consistente
  Widget _buildButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      icon: Icon(icon, size: 24),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
