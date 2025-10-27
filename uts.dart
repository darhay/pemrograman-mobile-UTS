//Kelas abstract Transportasi
abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar;

  double hitungTarif(int jumlahPenumpang);

  void tampilInfo() {
    print("ID: $id");
    print("Nama: $nama");
    print("Tarif Dasar: $_tarifDasar");
    print("ID: $kapasitas");
  }
}

//Kelas Taksi (Inheritan ke kelas Transportasi)
class Taksi extends Transportasi {
  double jarak;

  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jarak;
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Jarak: $jarak");
  }
}

//Kelas Bus (Inheritan ke kelas Transportasi)
class Bus extends Transportasi {
  bool adaWifi;

  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Ada Wifi: ${adaWifi ? "Ya" : "Tidak"}");
  }
}

//Kelas Pesawat (Inheritan ke kelas Transportasi)
class Pesawat extends Transportasi {
  String kelas;

  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jumlahPenumpang * (kelas == "Bisnis" ? 1.5 : 1.0);
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Kelas: $kelas");
  }
}

//Kelas Pemesanan
class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(
    this.idPemesanan,
    this.namaPelanggan,
    this.transportasi,
    this.jumlahPenumpang,
    this.totalTarif,
  );

  void cetakStruk() {
    print("============================");
    print("ID Pemesanan: $idPemesanan");
    print("Nama Pelanggan: $namaPelanggan");
    transportasi.tampilInfo();
    print("Jumlah Penumpang: $jumlahPenumpang orang");
    print("Total Tarif: $totalTarif");
    print("============================");
  }

  Map<String, dynamic> toMap() {
    return {
      'idPemesanan': idPemesanan,
      'namaPelanggan': namaPelanggan,
      'transportasi': transportasi.nama,
      'jumlahPenumpang': jumlahPenumpang,
      'totalTarif': totalTarif,
    };
  }
}

// Fungsi Global
//buat pemesanan
Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
  double total = t.hitungTarif(jumlahPenumpang);
  String idPemesanan = "P${DateTime.now().millisecondsSinceEpoch}";
  return Pemesanan(idPemesanan, nama, t, jumlahPenumpang, total);
}

//tampilkan semua pemesanan
void tampilSemuaPemesanan(List<Pemesanan> daftar) {
  for (var p in daftar) {
    p.cetakStruk();
  }
}

//Fungsi Main
void main(List<String> args) {
  //buat list/daftar pemesanan
  List<Pemesanan> daftarPemesanan = [];

  //buat objek Transportasi
  Taksi taksi1 = Taksi("T001", "Blue Bird", 7000, 4, 15.5);
  Bus bus1 = Bus("B001", "Trans Bandung", 6000, 40, true);
  Pesawat pesawat1 = Pesawat("P001", "Batik Air", 1350000, 180, "Bisnis");

  //buat pemesanan, tambahkan di list daftarPemesanan
  daftarPemesanan.add(buatPemesanan(taksi1, "Haydar", 1));
  daftarPemesanan.add(buatPemesanan(bus1, "Titha", 2));
  daftarPemesanan.add(buatPemesanan(pesawat1, "Lukman", 3));

  //tampilkan semua transaksi
  tampilSemuaPemesanan(daftarPemesanan);
}
