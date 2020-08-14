import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Index(),
    );
  }
}

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;
  onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _viewList = [Home(), Home(), Home()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _viewList.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: onTappedItem,
        selectedIndex: _selectedIndex,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.lightBlue,
            inactiveColor: kBlackColor,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('My Cart'),
            activeColor: Colors.lightBlue,
            inactiveColor: kBlackColor,
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text('My Profile'),
            activeColor: Colors.lightBlue,
            inactiveColor: kBlackColor,
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 25.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Food App", style: kTitle1Style),
                              TextSpan(
                                  text: " Palawan ",
                                  style: kTitle2Style.copyWith(
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, top: 0, right: 5, bottom: 0),
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kGreyColor),
                          ),
                          child: Icon(Icons.search),
                        ),
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kGreyColor),
                          ),
                          child: Icon(Icons.list),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 0.2,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: TabBar(
                        isScrollable: true,
                        labelStyle: kTitle1Style,
                        labelColor: Colors.blue,
                        unselectedLabelColor: kGreyColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                ),
                                SizedBox(width: 15.0),
                                Tab(
                                  text: "Popular",
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_offer,
                                ),
                                SizedBox(width: 14.0),
                                Tab(
                                  text: "New",
                                ),
                                SizedBox(width: 30.0),
                              ],
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            DeliveryTab(),
            PickupTab(),
          ],
        ),
      ),
    );
  }
}

class DeliveryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular Foods",
              style: kTitle1Style.copyWith(fontSize: 22.0),
            ),
            Container(
              width: double.infinity,
              height: 250.0,
              child: ListView.builder(
                itemCount: recommendedList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var product = recommendedList[index];

                  return ProductCard(
                    product: product,
                    isRecommended: true,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Image.network(
                "https://gmbmarketing.net/wp-content/uploads/2017/10/restaurant-banner-1.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 25.0),
            GridView.builder(
                itemCount: recommendedList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.0 / 1.3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemBuilder: (coontent, index) {
                  var product = recommendedList[index];
                  return InkWell(
                    onTap: () {},
                    child: ProductCard(
                      product: product,
                      isRecommended: false,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class PickupTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Foods",
              style: kTitle1Style.copyWith(fontSize: 22.0),
            ),
            SizedBox(height: 25.0),
            GridView.builder(
                itemCount: recommendedList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.0 / 1.3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemBuilder: (coontent, index) {
                  var product = recommendedList[index];
                  return InkWell(
                    onTap: () {},
                    child: ProductCard(
                      product: product,
                      isRecommended: false,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isRecommended;

  ProductCard({this.product, this.isRecommended});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      padding: EdgeInsets.all(2.0),
      margin: EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isRecommended
              ? Chip(
                  backgroundColor: kRedColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  label: Text(
                    "Hot",
                    style: kChipStyle,
                  ),
                )
              : Container(),
          Expanded(
            child: Center(
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: kTitle1Style,
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "\₱${product.price}",
                  style: kSubtitleStyle,
                ),
                Text("00", style: kSubtitleStyle),
              ],
            ),
            trailing: Container(
              width: 78.0,
              height: 25.0,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Text(
                "Add to Cart",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String price;
  final String image;

  Product({
    this.image,
    this.name,
    this.price,
  });
}

List<Product> recommendedList = [
  Product(
    name: "Pizza",
    price: "12",
    image:
        "https://www.pizzaexpress.com.my/wp-content/uploads/2017/06/beef-cheese.png",
  ),
  Product(
    name: "Isaw",
    price: "12",
    image:
        "https://simplybakings.com/wp-content/uploads/2020/03/Isaw-49-225x225.jpg",
  ),
  Product(
    name: "Hotdog",
    price: "12",
    image:
        "https://image.shutterstock.com/image-photo/hot-dog-mustard-ketchup-side-260nw-683413162.jpg",
  ),
  Product(
    name: "Daing",
    price: "12",
    image:
        "https://upload.wikimedia.org/wikipedia/commons/8/88/Daing_na_bangus.jpg",
  ),
  Product(
    name: "Turon",
    price: "12",
    image:
        "https://themayakitchen.com/wp-content/uploads/2019/10/TURON-500x500.jpg",
  ),
];

const kOrangeColor = Color(0xFFFFA451);
const kOrangeAccentColor = Color(0xFFFEE6A7);
const kGreyColor = Color(0xFFB2B4C1);
const kBlackColor = Color(0xFF232323);
const kWhiteColor = Color(0xFFF9FAFB);
const kRedColor = Color(0xFFFF7051);
const kBrownColor = Color(0xFF6C6C6C);

var kTitle1Style = GoogleFonts.roboto(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);
var kTitle2Style = GoogleFonts.roboto(
  fontSize: 18.0,
  color: kBlackColor,
);

var kSubtitleStyle = GoogleFonts.roboto(
  fontSize: 15.0,
  color: kGreyColor,
);
var kSubtitle2Style = GoogleFonts.roboto(
  fontSize: 10.0,
  color: kGreyColor,
);

var kChipStyle = GoogleFonts.roboto(
  fontSize: 15.0,
  color: kWhiteColor,
);

var kDescriptionStyle = GoogleFonts.roboto(
  fontSize: 16.0,
  color: kBrownColor,
  height: 1.5,
);
