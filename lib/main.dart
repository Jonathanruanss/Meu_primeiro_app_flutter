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
      // Define o tema do aplicativo com um esquema de cores personalizado
      theme: ThemeData(
        // ==============================================
        // PALETA DE CORES COM FUNDO BRANCO E APPBAR LARANJA
        // ==============================================
        colorScheme:
            ColorScheme.fromSwatch(
              primarySwatch: Colors.grey, // Cor principal para a AppBar
            ).copyWith(
              secondary: Colors.orange.shade700, // Cor de destaque (laranja)
              surface: Colors.white, // Cor de fundo clara para o conteúdo
              onSurface: Colors.black, // Cor do texto em superfícies claras
              onPrimary: Colors.white, // Cor do texto na AppBar
              onSecondary:
                  Colors.white, // Cor do texto em botões com cor de destaque
            ),
        scaffoldBackgroundColor: Colors.white, // Cor de fundo do Scaffold
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
  final String whatsappComercial = '5531999999999';
  final String whatsappSuporte = '5531988888888';
  final String whatsappFinanceiro = '5531977777777';
  final String whatsappAdicional = '5548988120743';

  // O deep link para abrir outro aplicativo.
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
      final String webUrl = 'https://wa.me/$phoneNumber';
      final Uri webUri = Uri.parse(webUrl);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri);
      } else {
        // Exibe um erro se não for possível abrir o WhatsApp
        throw 'Não foi possível abrir o WhatsApp.';
      }
    }
  }

  // Função para abrir um URL (para o deep link)
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // Exibe um erro se não for possível abrir o link
      throw 'Não foi possível abrir o aplicativo ou o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contato Direto'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ==============================================
              // GRID DE BOTÕES QUADRADOS DO WHATSAPP
              // ==============================================
              GridView.count(
                // Desabilita o scroll da grade para que ela se ajuste ao conteúdo
                physics: const NeverScrollableScrollPhysics(),
                // Permite que o GridView seja redimensionado com o conteúdo
                shrinkWrap: true,
                // Define 2 colunas
                crossAxisCount: 2,
                // Espaçamento entre as colunas
                crossAxisSpacing: 16.0,
                // Espaçamento entre as linhas
                mainAxisSpacing: 16.0,
                // Aspecto 1.0 para manter a forma quadrada
                childAspectRatio: 1.0,
                children: [
                  // Botão para o WhatsApp Comercial
                  _buildWhatsAppButton(
                    context,
                    text: 'Comercial',
                    icon: Icons.business,
                    onPressed: () => _launchWhatsApp(whatsappComercial),
                  ),

                  // Botão para o WhatsApp Suporte Técnico
                  _buildWhatsAppButton(
                    context,
                    text: 'Suporte',
                    icon: Icons.support_agent,
                    onPressed: () => _launchWhatsApp(whatsappSuporte),
                  ),

                  // Botão para o WhatsApp Financeiro
                  _buildWhatsAppButton(
                    context,
                    text: 'Financeiro',
                    icon: Icons.account_balance,
                    onPressed: () => _launchWhatsApp(whatsappFinanceiro),
                  ),

                  // NOVO BOTÃO: WhatsApp Contato Adicional
                  _buildWhatsAppButton(
                    context,
                    text: 'Adicional',
                    icon: Icons.phone_in_talk,
                    onPressed: () => _launchWhatsApp(whatsappAdicional),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ==============================================
              // BOTÃO RETANGULAR PARA ABRIR OUTRO APLICATIVO
              // ==============================================
              _buildLargeButton(
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

  // Widget de helper para criar os botões quadrados do WhatsApp
  Widget _buildWhatsAppButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Fundo branco
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        // Sombra laranja
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Widget de helper para criar o botão retangular grande
  Widget _buildLargeButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        // Fundo branco
        backgroundColor: Colors.white,
        // Texto preto para contraste com o fundo branco
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 10,
        // Sombra laranja
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      ),
      icon: Icon(icon, size: 24),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
