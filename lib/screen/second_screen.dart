import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/others.dart';
import 'package:flutter_application_1/models/trans_model.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);
  static const routeName = '/secondscreen';

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller; //
  Animation<double>? _animation;

  @override
  void initState() {
    // initialize animation controllers.
    _controller = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
      value: 0.1,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.bounceIn,
    );
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    //dispose controllers
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as TransModel;

    return Scaffold(
      backgroundColor: Color(0xff6c648e),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff6c648e),
        //title: const Text("Second"),
      ),
      body: Container(
        margin: pageMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appText(
              "Transaction details",
              22,
              color: Colors.white,
              weight: FontWeight.w700,
              bottommargin: 24.0,
            ),
            ScaleTransition(
              scale: _animation!,
              child: Container(
                //color: Colors.white,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(calculateSize(10)),
                ),
                padding: EdgeInsets.symmetric(horizontal: calculateSize(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText("Detailed summary of transaction", 16,
                        color: primaryColor,
                        topmargin: 36.0,
                        bottommargin: 22.0),
                    widgetSummary("Recipient", "John"),
                    widgetSummary("Amount", "N ${args.amount}"),
                    widgetSummary(
                        "Transaction date", formatDate(args.date.toString())),
                    widgetSummary("Reference", args.id),
                    widgetSummary("Status", "Successful", suc: true),
                    SizedBox(
                      height: calculateSize(25),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatDate(String date) {
    if (date == null) {
      return "N/A";
    }
    var str = date.substring(0, 10);

    //2022-03-09T09:26:19+0000
    //print("str..............$str");
    DateTime dt = DateTime.parse(str);
    //print("dtdtdtdtdtdtdtdtdt..............$dt");
    return DateFormat.yMMMMd().format(dt);
  }
}

class widgetSummary extends StatelessWidget {
  //const xx({Key? key}) : super(key: key);
  var title;
  var value;
  bool suc;
  widgetSummary(this.title, this.value, {this.suc = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            appText(
              title,
              16,
              color: Color(0xff707070),
            ),
            Spacer(),
            appText(
              value,
              17,
              weight: FontWeight.w700,
              color: !suc ? Color(0xff3B3B3B) : Colors.green,
            ),
          ],
        ),
        SizedBox(
          height: calculateSize(25),
        )
      ],
    );
  }
}
