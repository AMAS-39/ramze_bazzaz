part of "imports.dart";

final _formatterIQD = NumberFormat("#,###", "en");
final _formatterUSD = NumberFormat("#,##0.00", "en");

String formatPrice(num? price, {bool symobl = true, bool isUSD = false}) {
  if (isUSD) {
    return "${_formatterUSD.format(price)} ${symobl ? (isUSD ? "USD" : "IQD") : ""}";
  }
  return "${_formatterIQD.format(price)} ${symobl ? (isUSD ? "USD" : "IQD") : ""}";
}

extension ForamtPrice on num {
  String get format {
    return formatPrice(this, symobl: false, isUSD: true);
  }

  String get formatIQD {
    return formatPrice(this, symobl: true, isUSD: false);
  }

  String get formatUSD {
    return formatPrice(this, symobl: true, isUSD: true);
  }
}
