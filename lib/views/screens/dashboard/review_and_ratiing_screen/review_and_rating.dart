import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

class ReviewScreen extends StatefulWidget {
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Vishwas Patel',
      'rating': 2.0,
      'date': '10 Sept 2024',
      'review': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'image':
          'https://s3-alpha-sig.figma.com/img/4cc7/25c2/d305e332b6bdb338ecbb6bf27452fa0f?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=NgWEpf148zE9Prtbh3tB~6uK6iTD0-vUOIQnsVyLk8sctEVqMf4DNrTfwes6GdY95vNOsco3r5jXINxt8USY~s8zX~GoTy2e~3rVcJ3uzXF2Q7T~pPQbVeqxrAguTsFkz9YWl7HPQsqV-vU0ywg6~Y493Kun9KQrqH5KtE79EK9Vc69iMgjETutM5t9acgTr0iGoq885fH40m00TiLSwZpH7YNLRXtWviH7MSn3XCQS-3olCB7ktjeE5BvzMWT~w75prHP9r385fcF10P6Hx77CdGqvdfErZwHyDX9RTzrWsMCPYhe1XmICxvt85kygJBqgTBlOAqab0QCoW15uyig__',
    },
    {
      'name': 'Vikas Tiwari',
      'rating': 1.0,
      'date': '10 Sept 2024',
      'review': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'image':
          'https://s3-alpha-sig.figma.com/img/4975/38e1/d339be91b10aa7a7aad2a051dc5790cf?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=I6FnXmkiDY4~n3yfJ58kA-LOKh0E8To7NnAl~Jqm9HD7Cx4QJUWPtTlISi5uW3GOnhdorMNxSqOlYBkNr-jdlEivEJeWHo0Uaz7t1qaEuxmh7p4feQzk-QUFsBAD~CT3raw3Qmoe9j3tg210g5lbie2nRIfYgQBXavoUYSZpamDpJF-HJ6b6XPgAL6iQgKrPDI~uKe3QrXQulGu8cg~Rhih8oHCUYDo~kgFLYLt9d9Ke49kVupz2OKQmcT3ZpO~fcdOaljX9V2vUAO78AU9tnDlfVdEpLCC7RShoO6hBOAzArrD2aCqHS2B346nyhCq1~GcGDavrvNF2TaH1zBT1DA__',
    },
    {
      'name': 'Hillery Moses',
      'rating': 4.0,
      'date': '10 Sept 2024',
      'review': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'image':
          'https://s3-alpha-sig.figma.com/img/e86a/eb8b/ac9546fc15e4d7f839fdca74952797d8?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=DO95QYacRuaJ8OBE0Lw0wZVUv0jPTgUdYUm-gpuBNJandCLYK3qzLpnyl6hvwQXGun8v0vhnf1ROtRkc6s4mU7VMJyo6DERtJggsp2nClT93UP5B4TzMiuOnBglnGgtLZykhugQy~TkCFAK~sw-pwThbxehEF1-vmediFC8z-p8UD2e9vD81EXT~iaike4eHVCoZxm4lOIwretG8sNfKKPK5lo0nbWcRHP5Cw9W26w3FHAUU1lSQBwjcynZIHC~31kk-hEraMP4mG-a~GEs2kh~L1EnBJJAEJMI-TZoe7kdcmIND3xVlZoX~6jJNsVeMI5prfn4XDY8Sg20-o6FmfA__',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Reviews & Ratings',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomImage(
                          path: review['image'],
                          radius: 6,
                          height: 40,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review['name']!,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ...List.generate(
                                        5,
                                        (starIndex) => Icon(
                                              starIndex < review['rating'] ? Icons.star : Icons.star_border,
                                              color: Colors.amber,
                                              size: 20,
                                            )),
                                    const SizedBox(width: 8),
                                    Text(
                                      review['rating'].toString(),
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  review['date']!,
                                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review['review']!,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
