import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';

class DetailPatternsPage extends StatefulWidget {
  @override
  DetailPatternsPageState createState() => DetailPatternsPageState();
}

class DetailPatternsPageState extends State<DetailPatternsPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 550.w,
            decoration: BoxDecoration(
              color: Colors.amber,
              boxShadow: [
                BoxShadow(
                  offset: Offset(8.w, 21.w),
                  blurRadius: 53.w,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45.w),
                bottomRight: Radius.circular(45.w),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 45.w, left: 30.w),
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    borderRadius: BorderRadius.all(Radius.circular(15.w)),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Asscending Triangle",
                  style: TextStyle(
                    fontFamily: "Nunito-ExtraBold",
                    fontSize: 33.ssp,
                    color: kTextColor,
                  ),
                ),
                SizedBox(height: 10.w),
                Text(
                  "Segitiga naik adalah jenis pola grafik segitiga yang terjadi ketika ada level resistensi dan kemiringan dari posisi terendah yang lebih tinggi. Apa yang terjadi selama ini adalah bahwa ada tingkat tertentu yang tampaknya tidak dapat dilampaui oleh pembeli. Namun, mereka secara bertahap mulai mendorong harga naik sebagaimana dibuktikan dengan posisi terendah yang lebih tinggi.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 25.ssp,
                    color: kTextMediumColor,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 40.w),
                    height: 280.w,
                    width: 480.w,
                    color: Colors.grey[100],
                  ),
                ),
                Text(
                  "Sekarang pertanyaannya adalah, “Ke arah mana itu akan pergi? Akankah pembeli bisa menembus level itu atau akankah perlawanan terlalu kuat? Banyak buku grafik akan memberi tahu Anda bahwa dalam banyak kasus, pembeli akan memenangkan pertarungan ini dan harga akan menembus resistance. Namun, menurut pengalaman kami, tidak selalu demikian. Terkadang level resistensi terlalu kuat, dan daya beli tidak cukup untuk mendorongnya. Seringkali, harga justru akan naik. Poin yang kami coba sampaikan adalah bahwa Anda tidak boleh terobsesi dengan arah mana harga bergerak, tetapi Anda harus siap untuk bergerak ke arah SALAH SATU. Dalam kasus ini, kami akan menetapkan perintah masuk di atas garis resistensi dan di bawah kemiringan dari posisi terendah yang lebih tinggi",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 25.ssp,
                    color: kTextMediumColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
