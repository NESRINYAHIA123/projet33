
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker_test_0/providers/image_merging_provider.dart';
import 'package:image_picker_test_0/providers/screens_provider.dart';
import 'package:image_picker_test_0/widgets/home_page_content.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_bottom_app_bar.dart';
import 'widgets/custom_drop_down_menu.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});




  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          leadingWidth: 150,
          leading: const Row(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomDropDownMenu()
              ),
            ],
          ),
        ),
        body: const HomePageContent(),
        bottomNavigationBar: context.watch<ImageMergingProvider>().getSourceUint8ListImage() != null && context.watch<ScreensProvider>().getScreenToShow() == ScreenToShow.sourceImageSelected
            ? CustomBottomAppBar()
            : null
    );
  }

}
