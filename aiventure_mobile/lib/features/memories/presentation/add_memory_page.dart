import 'package:flutter/material.dart';

class AddMemoryPage extends StatefulWidget {
  const AddMemoryPage({super.key});

  @override
  State<AddMemoryPage> createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter Souvenir')),
      body: Center(
        child: _uploading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _pickAndUpload,
                child: const Text('Choisir une photo'),
              ),
      ),
    );
  }

  Future<void> _pickAndUpload() async {
    setState(() => _uploading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _uploading = false);
    Navigator.of(context).pop();
  }
}
