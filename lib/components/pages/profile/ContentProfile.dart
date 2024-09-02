import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContentProfile extends StatefulWidget {
  final bool isMobile;

  const ContentProfile({Key? key, required this.isMobile}) : super(key: key);

  @override
  _ContentProfileState createState() => _ContentProfileState();
}

class _ContentProfileState extends State<ContentProfile> {
  XFile? _image;  // Menyimpan gambar yang dipilih
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Bagian untuk informasi profil
              Expanded(
                flex: 2,
                child: Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: widget.isMobile ? 60 : 80,
                      backgroundImage: _image == null
                          ? const AssetImage('assets/luffy.jpg')
                          : FileImage(File(_image!.path)) as ImageProvider,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Card dengan form input dan scroll
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: widget.isMobile ? 18 : 22,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildFormField('Nomor Induk Pegawai', '123456789', widget.isMobile),
                          _buildFormField('First Name', 'John', widget.isMobile),
                          _buildFormField('Last Name', 'Doe', widget.isMobile),
                          _buildFormField('Email', 'john.doe@example.com', widget.isMobile),
                          _buildFormField('Alamat', '123 Main Street', widget.isMobile),
                          _buildFormField('Tanggal Lahir', '01/01/1990', widget.isMobile),
                          _buildFormField('Nomor Rekening', '9876543210', widget.isMobile),
                          _buildFormField('Nama Bank', 'Bank XYZ', widget.isMobile),
                          _buildFormField('Role', 'Software Engineer', widget.isMobile),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFormField(String label, String value, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              enabled: false,
              style: TextStyle(fontSize: isMobile ? 14 : 16),
            ),
          ),
        ],
      ),
    );
  }
}
