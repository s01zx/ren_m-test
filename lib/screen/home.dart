import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/app_provider.dart';
import 'package:flutter_application_1/helpers/others.dart';
import 'package:flutter_application_1/models/trans_model.dart';
import 'package:flutter_application_1/screen/second_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool doneLoading = false;
  List<TransModel> listtrans = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) => getHistory());

    super.initState();
  }

  Future<void> getHistory() async {
    try {
      doneLoading = await Provider.of<AppProvider>(context, listen: false)
          .getTransactionHistory();
      listtrans =
          Provider.of<AppProvider>(context, listen: false).transactionlist;
    } on Exception catch (e) {
      // TODO
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: primaryColor,
      ),
      body: doneLoading
          ? Container(
              margin: pageMargin,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText("All Transactions", 22,
                        color: primaryColor,
                        weight: FontWeight.w700,
                        bottommargin: 23.0),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: listtrans.length,
                      itemBuilder: (ctx, i) => GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            SecondScreen.routeName,
                            arguments: listtrans[i]),
                        child: TransactionTile(
                          title: listtrans[i].desc,
                          imageasset: listtrans[i].type == "DEPOSIT"
                              ? "assets/images/down.png"
                              : "assets/images/up.png",
                          amount: appText(listtrans[i].amount.toString(), 16,
                              weight: FontWeight.w700,
                              color: listtrans[i].type == "DEPOSIT"
                                  ? Color(0xff65C4AD)
                                  : Colors.redAccent),
                          subtitle: listtrans[i].date,
                          id: listtrans[i].id,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: LottieBuilder.asset(
                "assets/images/lf30_editor_3u5ldj2s.json",
                repeat: true,
                reverse: false,
                animate: true,
                width: calculateSize(100),
                height: calculateSize(100),
              ),
            ),
    );
  }
}
