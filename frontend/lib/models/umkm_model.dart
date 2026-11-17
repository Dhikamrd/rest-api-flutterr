class Umkm {
  final int? id;
  final String namaUmkm;
  final String kategori;
  final String pemilik;
  final String alamat;
  final String kontak;

  Umkm({
    this.id,
    required this.namaUmkm,
    required this.kategori,
    required this.pemilik,
    required this.alamat,
    required this.kontak,
  });

  factory Umkm.fromJson(Map<String, dynamic> json) {
    return Umkm(
      id: int.tryParse(json['id'].toString()),
      namaUmkm: json['nama_umkm'] ?? '',
      kategori: json['kategori'] ?? '',
      pemilik: json['pemilik'] ?? '',
      alamat: json['alamat'] ?? '',
      kontak: json['kontak'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_umkm': namaUmkm,
      'kategori': kategori,
      'pemilik': pemilik,
      'alamat': alamat,
      'kontak': kontak,
    };
  }
}
