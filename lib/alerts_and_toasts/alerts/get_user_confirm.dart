part of "export.dart";

Future<bool?> getUserConfirm(
    {required String desc,
    String? title,
    String? okText,
    String? canceLText}) async {
  return await showModalBottomSheet<bool?>(
      context: Helper.i.context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return NewWidget(
            desc: desc, title: title, okText: okText, canceLText: canceLText);
      });
}

class NewWidget extends StatelessWidget {
  const NewWidget(
      {super.key,
      this.title,
      this.okText,
      this.canceLText,
      required this.desc});
  final String? title;
  final String? okText;
  final String? canceLText;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,
        top: true,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(height: 20),
              Container(
                width: 75,
                height: 8,
                decoration: BoxDecoration(
                    color: context.primaryColor,
                    borderRadius: BorderRadius.circular(BORDER_RADUIS)),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: context.titleStyle.copyWith(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GeneralButton(
                          padding: const EdgeInsets.all(12),
                          radius: 45,
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          color: context.scaffoldBackgroundColor,
                          fontSize: 14,
                          border: true,
                          text: canceLText ?? Trans.no.trans(),
                          txtColor: context.titleStyle.color),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GeneralButton(
                          radius: 45,
                          padding: const EdgeInsets.all(12),
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                          fontSize: 14,
                          text: okText ?? Trans.yes.trans(),
                          txtColor: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ])));
  }
}
