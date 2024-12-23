# persistansi
1. late Future<List<dynamic>> cryptoDataFuture; 
  digunakan untuk menyimpan proses pengambilan data asinkron dari API
   List<dynamic>? filteredData;
  digunakan untuk menyimpan hsil data yang sudah di filter
2. ketika widget sudah dibuat maka iniState memulai proses pengambilan data mengguanakan fetchCrypto() dan ketika selesai diambil maka UI akan memeprbarui tampilan
3. daftar data kripto yang difilter pada List<dynamic> data lalu dicari menggunaakan parameter pencarian String query. lalu setState memberitahu flutter bahwa ada perubahan widget sehingga UI akan diperbarui.
ketika pengguna tidak mengetikkan apapun dalam pencarian maka vriable filteredData diatur menjadi null. ketika query atau pencarian tidak kosong maka diproses dalam 
    filteredData = data.where((crypto) { //memfilter lemen dlm daftar data
  return crypto['name'] //mengakses nama crypto berdasarkan dta pada API
      .toString() // mengubah nama menjadi string agar dapat diproses
      .toLowerCase() //mengubah teks menjadi huruf kecil
      .contains(query.toLowerCase()); // memeriksa apakah ada nama crypto yang sama dengan query atau pencarian
}).toList(); //mengubah where menjadi daftar list\

4. pada bagian body menggunakan body: FutureBuilder<List<dynamic>> membuat widget yang secara dinamis membangun UI berdasarkan status dari Future.  
lalu pada future: cryptoDataFuture digunakan untuk mewakili proses assinkron untuk mengambil data dari API

5. lalu melakukan looping ketika snapshot.connectionState masih menunggu maka akan ditampilkan CircularProgressIndicator(), dan jika snapshot error maka akan ditampilkan  pesan error Text('Error: ${snapshot.error}'), dan ketika sudah mendapatkan data maka akan dieksekusi pada  List<dynamic> data = filteredData ?? snapshot.data!; jika filterdata bernilai null maka data akan emngambil nilai dari snapshot.data, jika filteredData not null maka data akan mengambil nilai pada filteredData. lalu data akan diurutkan diirutuan menurun pada sintak  data.sort(
                (a, b) => b['current_price'].compareTo(a['current_price']));
6. pada bagian Textfield terdapat
   onChanged: (value) {
                      filterCrypto(value, snapshot.data!);
                    },
   yang mana ketika pengguna mengetikkan atau mengubah nilai input maka akan memanggil filterCrypto lalu emngirimkan nilai input pengguna dan data asli sebagai parameter, selanjutnya mengupdate daftar data yang ditampilkan berdasarkan input pengguna.
7. terakhir pada ListView menggunakan Card yang didalamnya terdapat image dengan sintak Text(crypto['name']), subtitilenya   Text('Price: \$${crypto['current_price']}' dan trailing nya untuk presentase menggunakan 
Text('Change: ${crypto['price_change_percentage_24h'].toStringAsFixed(2)}%'., ditambah ketika  crypto['price_change_percentage_24h'] nilainya lebih besar dari sama dengan 0 maka akan ditampilkan dengan tulisan warna hijau jika tidak maka ditampilkan warna merah.


---------- HASIL ------------
![image](https://github.com/user-attachments/assets/301b5f10-4deb-4064-8006-8646ab029c51)

![image](https://github.com/user-attachments/assets/fe48b165-4445-45ec-89f6-f5b5ced14094)




A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
