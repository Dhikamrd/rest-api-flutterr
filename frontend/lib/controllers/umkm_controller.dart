import 'package:get/get.dart';

import '../models/umkm_model.dart';
import '../services/api_service.dart';

class UmkmController extends GetxController {
  final ApiService apiService = ApiService();

  var daftarUmkm = <Umkm>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ambilDataUmkm();
  }

  Future<void> ambilDataUmkm() async {
    try {
      isLoading.value = true;
      daftarUmkm.value = await apiService.getUmkm();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data UMKM: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> tambahUmkm(Umkm umkm) async {
    try {
      bool berhasil = await apiService.tambahUmkm(umkm);

      if (berhasil) {
        Get.back();
        Get.snackbar('Berhasil', 'Data UMKM berhasil ditambahkan');
        await ambilDataUmkm();
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan data: $e');
    }
  }

  Future<void> updateUmkm(Umkm umkm) async {
    try {
      bool berhasil = await apiService.updateUmkm(umkm);

      if (berhasil) {
        Get.back();
        Get.snackbar('Berhasil', 'Data UMKM berhasil diperbarui');
        await ambilDataUmkm();
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui data: $e');
    }
  }

  Future<void> hapusUmkm(int id) async {
    try {
      bool berhasil = await apiService.hapusUmkm(id);

      if (berhasil) {
        Get.snackbar('Berhasil', 'Data UMKM berhasil dihapus');
        await ambilDataUmkm();
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus data: $e');
    }
  }
}
