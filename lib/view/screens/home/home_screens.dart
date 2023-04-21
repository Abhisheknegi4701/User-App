import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/auth_provider.dart';
import 'package:flutter_grocery/provider/banner_provider.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/provider/localization_provider.dart';
import 'package:flutter_grocery/provider/product_provider.dart';
import 'package:flutter_grocery/provider/wishlist_provider.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/view/base/footer_view.dart';
import 'package:flutter_grocery/view/base/title_widget.dart';
import 'package:flutter_grocery/view/base/web_app_bar/web_app_bar.dart';
import 'package:flutter_grocery/view/screens/home/widget/banners_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/category_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/home_item_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/product_view.dart';
import 'package:provider/provider.dart';

import '../../../utill/images.dart';

class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [Images.update, Images.maintenance];

  Future<void> _loadData(BuildContext context, bool reload) async {
     Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,reload,
     );

     Provider.of<BannerProvider>(context, listen: false).getBannerList(context, reload);

     await Provider.of<ProductProvider>(context, listen: false).getDailyNeeds(
       context,'1', true, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
     );

    await Provider.of<ProductProvider>(context, listen: false).getPopularProductList(
       context,'1', true, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
     );

    await Provider.of<ProductProvider>(context, listen: false).getLatestProductList(
       context,'1', true, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
     );
     if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
       await Provider.of<WishListProvider>(context, listen: false).getWishList(context);
     }

  }

  @override
  void initState() {
    _loadData(context, false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.asset(item, fit: BoxFit.fill, width: 1000.0),
              ],
            )),
      ),
    ))
        .toList();

    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<ProductProvider>(context, listen: false).offset = 1;
        Provider.of<ProductProvider>(context, listen: false).popularOffset = 1;
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120))  : null,
        body: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Center(
                  child: SizedBox(width: 1170,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: ResponsiveHelper.isDesktop(context)
                          ? MediaQuery.of(context).size.height - 400
                          : MediaQuery.of(context).size.height,
                      ),
                      child: Column(
                          children: [

                        Consumer<BannerProvider>(builder: (context, banner, child) {
                          return banner.bannerList == null ? BannersView() : Container(
                              width: MediaQuery.of(context).size.width,
                              height: ResponsiveHelper.isDesktop(context) ? 400 : MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_SMALL),
                              child: Column(
                              children: [
                                imgList.isNotEmpty? Expanded(
                                  child: Stack(
                              fit: StackFit.expand,
                              children: [
                                  CarouselSlider(
                                    items: imageSliders,
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: 2.0,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        }),
                                  ),
                                  Positioned(
                                    bottom: 5, left: 0, right: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: imgList.asMap().entries.map((entry) {
                                        return GestureDetector(
                                          onTap: () => _controller.animateToPage(entry.key),
                                          child: Container(
                                            width: 12.0,
                                            height: 12.0,
                                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: (Theme.of(context).brightness == Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black)
                                                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                              ],
                            ),
                                ) : Center(child: Text(getTranslated('no_banner_available', context)))
                              ],
                            ),
                          );
                        }),

                        // Category
                        Consumer<CategoryProvider>(builder: (context, category, child) {
                          return category.categoryList == null ? CategoryView() : category.categoryList.length == 0 ? SizedBox() : CategoryView();
                        }),

                       // Category
                        SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : 0),

                        TitleWidget(title: getTranslated('daily_needs', context) ,onTap: () {
                          Navigator.pushNamed(context, RouteHelper.getHomeItemRoute('daily_needs'));
                        }),
                        Consumer<ProductProvider>(builder: (context, product, child) {
                          return product.dailyItemList == null ? HomeItemView(isDailyItem: true) : product.dailyItemList.length == 0
                              ? SizedBox() : HomeItemView(isDailyItem: true);
                        }),

                        TitleWidget(title: getTranslated('popular_item', context) ,onTap: () {
                          Navigator.pushNamed(context, RouteHelper.getHomeItemRoute('popular_item'));
                        }),

                        Consumer<ProductProvider>(builder: (context, product, child) {
                          return product.latestProductList == null ? HomeItemView(isDailyItem: false) : product.latestProductList.length == 0
                              ? SizedBox() : HomeItemView(isDailyItem: false);
                        }),


                        ResponsiveHelper.isMobilePhone() ? SizedBox(height: 10) : SizedBox.shrink(),
                        TitleWidget(title: getTranslated('latest_items', context)),
                        ProductView(scrollController: _scrollController),

                      ]),
                    ),
                  ),
                ),
                ResponsiveHelper.isDesktop(context) ? FooterView() : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
