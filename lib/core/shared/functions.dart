part of "imports.dart";

void recoredError(dynamic e, dynamic c) {
  if (kReleaseMode && !kIsWeb) {
    FirebaseCrashlytics.instance.recordError(e, c);
  }
}

//

String checkOnNullReturnEmpty(String? str, {String def = ""}) {
  if (["", null, "null"].contains(str)) {
    return def;
  }
  return str ?? def;
}

Future<void> signOut({required bool showConfirm}) async {
  sl<AccountBloc>().add(AccountLogoutEvent(showConfirm: showConfirm));
}

String? skipHtml(String? htmlString) {
  try {
    if (htmlString == null) return null;
    var document = parse(htmlString);
    String parsedString =
        parse(document.body?.text).documentElement?.text ?? "";
    return parsedString;
  } catch (e) {
    return null;
  }
}

String? formatAttachment(String? val) {
  if (val.toString().startsWith("http")) {
    return val;
  } else {
    if (checkIsNull(val) != true) {
      val = val.toString().replaceAll("\\", "/");
      if (!val.startsWith("/")) {
        val = "/$val";
      }
      return "${appConfig.url}${val.toString()}";
    } else {
      return null;
    }
  }
}

MetaModel compineMeta(MetaModel orginal, MetaModel newOne) {
  return orginal.copyWith(
      xTotalCount: newOne.xTotalCount,
      xTotalSets: newOne.xTotalSets,
      pageSize: orginal.pageSize,
      page: newOne.page + 1);
}

int currentPage(bool refresh, MetaModel metaModel) {
  return refresh ? firstPage : metaModel.page;
}
