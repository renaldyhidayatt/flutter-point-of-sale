import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ContentNoteList extends StatefulWidget {
  final bool isTablet;
  final bool isDesktop;
  final bool isLargeDesktop;

  const ContentNoteList({
    Key? key,
    required this.isTablet,
    required this.isDesktop,
    required this.isLargeDesktop,
  }) : super(key: key);

  @override
  _ContentNoteListState createState() => _ContentNoteListState();
}

class _ContentNoteListState extends State<ContentNoteList> {
  List<Map<String, dynamic>> notes = [
    {'title': 'Note 1', 'date': '2024-08-31', 'status': 'Active'},
    {'title': 'Note 2', 'date': '2024-08-30', 'status': 'Completed'},
  ];

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotes = notes.where((note) {
      return note['title'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          SizedBox(height: 16),
          _buildActionButtonImports(),
          SizedBox(height: 16),
          Text(
            'Note List',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize:
                      widget.isLargeDesktop ? 24 : (widget.isDesktop ? 20 : 18),
                ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildNoteList(filteredNotes),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search',
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  Widget _buildActionButtonImports() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton.icon(
        onPressed: _createNoteDialog,
        icon: Icon(Icons.add),
        label: Text('Tambah'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent, // Warna latar belakang biru
          foregroundColor: Colors.white, // Warna teks putih
        ),
      ),
      SizedBox(width: 8),
      ElevatedButton.icon(
        onPressed: _importNotes,
        icon: Icon(Icons.file_upload),
        label: Text('Import'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Warna latar belakang hitam
          foregroundColor: Colors.white, // Warna teks putih
        ),
      ),
      SizedBox(width: 8),
      ElevatedButton.icon(
        onPressed: _exportNotes,
        icon: Icon(Icons.file_download),
        label: Text('Export'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Warna latar belakang hitam
          foregroundColor: Colors.white, // Warna teks putih
        ),
      ),
    ],
  );
  }

  Widget _buildNoteList(List<Map<String, dynamic>> filteredNotes) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: _calculateMinTableWidth(
                  filteredNotes), // Set minimum width for horizontal scroll
            ),
            child: DataTable(
              columnSpacing: _getColumnSpacing(), // Jarak antar kolom
              columns: [
                DataColumn(label: _getColumnLabel('Title')),
                DataColumn(label: _getColumnLabel('Date')),
                DataColumn(label: _getColumnLabel('Status')),
                DataColumn(label: _getColumnLabel('Actions')),
              ],
              rows: filteredNotes.map<DataRow>((note) {
                return DataRow(
                  cells: [
                    DataCell(_buildCellContent(note['title'])),
                    DataCell(_buildCellContent(note['date'])),
                    DataCell(_buildCellContent(note['status'])),
                    DataCell(
                      _buildActionButtons(notes.indexOf(note)),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateMinTableWidth(List<Map<String, dynamic>> notes) {
    double baseWidth = 100.0; // Base width for each column
    double titleWidth = baseWidth + 100; // Extra width for the title column
    double dateWidth = baseWidth + 60; // Extra width for the date column
    double statusWidth = baseWidth + 80; // Extra width for the status column
    double actionsWidth = baseWidth + 160; // Extra width for the actions column

    // Calculate the total minimum width needed for the table
    return titleWidth + dateWidth + statusWidth + actionsWidth;
  }

  Widget _getColumnLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: _getFontSize(), // Ukuran font responsif
      ),
    );
  }

  Widget _buildCellContent(String content) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(), // Padding horizontal responsif
      ),
      child: Text(content),
    );
  }

  Widget _buildActionButtons(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: () => _editNoteDialog(index),
          icon: Icon(Icons.edit),
          label: Text('Edit'),
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent, // Warna latar belakang hitam
          foregroundColor: Colors.white, // Warna teks putih
        ),
        ),
        SizedBox(width: _getButtonSpacing()), // Jarak antara tombol
        ElevatedButton.icon(
          onPressed: () => _deleteNote(index),
          icon: Icon(Icons.delete),
          label: Text('Hapus'),
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Warna latar belakang hitam
          foregroundColor: Colors.white, // Warna teks putih
        ),
        ),
      ],
    );
  }

  double _getColumnSpacing() {
    if (widget.isLargeDesktop) {
      return 380.0; // Jarak antar kolom untuk largeDesktop
    } else if (widget.isDesktop) {
      return 200.0; // Jarak antar kolom untuk desktop
    } else if (widget.isTablet) {
      return 50.0; // Jarak antar kolom untuk tablet
    } else {
      return 10.0; // Jarak antar kolom untuk mobile
    }
  }

  double _getHorizontalPadding() {
    if (widget.isLargeDesktop) {
      return 16.0; // Padding horizontal untuk largeDesktop
    } else if (widget.isDesktop) {
      return 12.0; // Padding horizontal untuk desktop
    } else if (widget.isTablet) {
      return 8.0; // Padding horizontal untuk tablet
    } else {
      return 4.0; // Padding horizontal untuk mobile
    }
  }

  double _getButtonSpacing() {
    if (widget.isLargeDesktop) {
      return 16.0; // Jarak antara tombol untuk largeDesktop
    } else if (widget.isDesktop) {
      return 12.0; // Jarak antara tombol untuk desktop
    } else if (widget.isTablet) {
      return 8.0; // Jarak antara tombol untuk tablet
    } else {
      return 4.0; // Jarak antara tombol untuk mobile
    }
  }

  double _getFontSize() {
    if (widget.isLargeDesktop) {
      return 18.0; // Ukuran font untuk largeDesktop
    } else if (widget.isDesktop) {
      return 16.0; // Ukuran font untuk desktop
    } else if (widget.isTablet) {
      return 14.0; // Ukuran font untuk tablet
    } else {
      return 12.0; // Ukuran font untuk mobile
    }
  }

  void _createNoteDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController statusController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  notes.add({
                    'title': titleController.text,
                    'date': DateTime.now().toString(),
                    'status': statusController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editNoteDialog(int index) {
    final note = notes[index];
    final TextEditingController titleController =
        TextEditingController(text: note['title']);
    final TextEditingController statusController =
        TextEditingController(text: note['status']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  notes[index] = {
                    'title': titleController.text,
                    'date': note['date'],
                    'status': statusController.text,
                  };
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _importNotes() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final contents = await file.readAsString();
        // Parse contents and update notes list
        List<Map<String, dynamic>> importedNotes = _parseNotes(contents);
        setState(() {
          notes = importedNotes;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notes imported successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing notes: $e')),
      );
    }
  }

  List<Map<String, dynamic>> _parseNotes(String contents) {
    List<Map<String, dynamic>> parsedNotes = [];
    List<String> lines = contents.split('\n');
    // Skip the header line
    for (int i = 1; i < lines.length; i++) {
      List<String> fields = lines[i].split(',');
      if (fields.length >= 3) {
        parsedNotes.add({
          'title': fields[0],
          'date': fields[1],
          'status': fields[2],
        });
      }
    }
    return parsedNotes;
  }

  void _exportNotes() async {
    try {
      // Convert notes list to CSV format
      String csv = 'Title,Date,Status\n';
      for (var note in notes) {
        csv += '${note['title']},${note['date']},${note['status']}\n';
      }

      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save CSV File',
        fileName: 'notes.csv',
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsString(csv);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notes exported successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error exporting notes: $e')),
      );
    }
  }
}
