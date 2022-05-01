import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_application/constants/colors.dart';
import 'package:news_application/constants/images.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/modules/favorite/favorite_provider.dart';
import 'package:news_application/widgets/circle_button.dart';
import 'package:news_application/widgets/glassmorphic_container.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
/// Always set Artical as an argument whenever calling [SinglePageView]
/// othervise this page won't work as expect
class SinglePageView extends StatefulWidget {
  static const String routeName = '/single-page';
  const SinglePageView({Key? key}) : super(key: key);

  @override
  State<SinglePageView> createState() => _SinglePageViewState();
}

class _SinglePageViewState extends State<SinglePageView> {
  @override
  Widget build(BuildContext context) {
    final artical = ModalRoute.of(context)?.settings.arguments as Article?;
    return Scaffold(
      floatingActionButton:
          Consumer<FavoriteProvider>(builder: (context, favProvider, child) {
        return SizedBox(
          height: 66,
          width: 66,
          child: CircleButton(
            icon: CupertinoIcons.heart,
            iconColor: favProvider.isFavorite(artical?.title)
                ? AppColors.secoundary
                : null,
            onTap: () {
              favProvider.toggleFavorite(
                News(
                  null,
                  artical?.title,
                  artical?.description,
                  artical?.content,
                  artical?.author,
                  artical?.urlToImage,
                  artical?.publishedAt.toString(),
                  artical?.source?.name,
                ),
              );
            },
          ),
        );
      }),
      body: Stack(children: [
        buildImage(),
        DraggableScrollableSheet(
          maxChildSize: 0.7,
          minChildSize: 0.5,
          builder: (context, scrollController) => SingleChildScrollView(
            clipBehavior: Clip.none,
            controller: scrollController,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                buildBody(),
                Positioned(
                  top: -100,
                  child: buildGlassmorphicContainer(),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: buildBackButton(),
        ),
      ]),
    );
  }

  Column buildImage() {
    final artical = ModalRoute.of(context)?.settings.arguments as Article?;
    final image = artical?.urlToImage ?? '';
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: FadeInImage.assetNetwork(
            placeholder: Images.placeHolder,
            image: image,
            imageErrorBuilder: (_, __, ___) => Image.asset(
              Images.placeHolder,
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
        const Expanded(flex: 2, child: SizedBox()),
      ],
    );
  }

  SizedBox buildBody() {
    final screen = MediaQuery.of(context).size;
    final artical = ModalRoute.of(context)?.settings.arguments as Article?;
    final content = artical?.content ?? '';
    return SizedBox(
      height: screen.height * 0.7,
      width: double.infinity,
      child: Material(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(26),
        ),
        elevation: 8,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 136.0, left: 18, right: 18),
          child: HtmlWidget(
            content,
            // textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }

  Container buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.blueGrey,
      ),
      child: IconButton(
        icon: const Icon(CupertinoIcons.back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  GlassmorphicContainer buildGlassmorphicContainer() {
    final screen = MediaQuery.of(context).size;
    final artical = ModalRoute.of(context)?.settings.arguments as Article?;
    final title = artical?.title ?? '';
    final author = artical?.author ?? '';
    final date =
        DateFormat.yMMMMEEEEd().format(artical?.publishedAt ?? DateTime.now());
    return GlassmorphicContainer(
      width: screen.width - 56,
      height: 200,
      borderRadius: 26,
      blur: 20,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blueGrey.withOpacity(0.3),
          Colors.blueGrey.withOpacity(0.2),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blueGrey.withOpacity(0.2),
          Colors.blueGrey.withOpacity(0.3),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              date,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 16),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Text(
              author,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
