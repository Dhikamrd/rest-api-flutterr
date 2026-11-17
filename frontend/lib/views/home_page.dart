import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/umkm_model.dart';
import '../controllers/umkm_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final UmkmController controller = Get.put(UmkmController());

  final namaController = TextEditingController();
  final kategoriController = TextEditingController();
  final pemilikController = TextEditingController();
  final alamatController = TextEditingController();
  final kontakController = TextEditingController();

  void tampilkanForm(BuildContext context, {Umkm? umkm}) {
    namaController.text = umkm?.namaUmkm ?? '';
    kategoriController.text = umkm?.kategori ?? '';
    pemilikController.text = umkm?.pemilik ?? '';
    alamatController.text = umkm?.alamat ?? '';
    kontakController.text = umkm?.kontak ?? '';

    Get.dialog(
      AlertDialog(
        title: Text(umkm == null ? 'Tambah UMKM' : 'Edit UMKM'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama UMKM'),
              ),
              TextField(
                controller: kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: pemilikController,
                decoration: const InputDecoration(labelText: 'Pemilik'),
              ),
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                controller: kontakController,
                decoration: const InputDecoration(labelText: 'Kontak'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (namaController.text.isEmpty ||
                  kategoriController.text.isEmpty ||
                  pemilikController.text.isEmpty ||
                  alamatController.text.isEmpty ||
                  kontakController.text.isEmpty) {
                Get.snackbar('Peringatan', 'Semua data harus diisi');
                return;
              }

              final data = Umkm(
                id: umkm?.id,
                namaUmkm: namaController.text,
                kategori: kategoriController.text,
                pemilik: pemilikController.text,
                alamat: alamatController.text,
                kontak: kontakController.text,
              );

              if (umkm == null) {
                controller.tambahUmkm(data);
              } else {
                controller.updateUmkm(data);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void konfirmasiHapus(int id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Hapus UMKM'),
        content: const Text('Apakah kamu yakin ingin menghapus data ini?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.hapusUmkm(id);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data UMKM'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.ambilDataUmkm,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.daftarUmkm.isEmpty) {
          return const Center(child: Text('Belum ada data UMKM'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.daftarUmkm.length,
          itemBuilder: (context, index) {
            final umkm = controller.daftarUmkm[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(
                  umkm.namaUmkm,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Kategori: ${umkm.kategori}\n'
                  'Pemilik: ${umkm.pemilik}\n'
                  'Alamat: ${umkm.alamat}\n'
                  'Kontak: ${umkm.kontak}',
                ),
                isThreeLine: true,
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      tampilkanForm(context, umkm: umkm);
                    } else if (value == 'hapus') {
                      konfirmasiHapus(umkm.id!);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'hapus', child: Text('Hapus')),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => tampilkanForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
