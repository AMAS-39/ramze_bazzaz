import 'package:app/core/shared/imports.dart';
import 'package:app/feature/stock/data/models/stock_item_model.dart';
import 'package:app/widgets/image_cheker.dart';
import 'package:app/widgets/image.dart';
import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  const StockCard({super.key, required this.item});
  final StockItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kIndent),
      decoration: BoxDecoration(
        color: appConfig.app == App.rbb ? context.cardColor : null,
        borderRadius: BorderRadius.circular(BORDER_RADUIS),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "#${item.id}",
                style: context.style16W500B,
              ),
              const SizedBox(width: 8),
              if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    final url = formatAttachment(item.imageUrl);
                    if (url != null) {
                      context.to(ImageViewScreen(
                        image: url,
                        title: item.title ?? "#${item.id}",
                      ));
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ImageChecker(
                      imageUrl: formatAttachment(item.imageUrl),
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          _Row(label: Trans.price.trans(), value: "${item.formattedPrice} USD"),
          _Row(label: Trans.qty.trans(), value: item.formattedQuantity),
          _Row(label: Trans.cbm.trans(), value: item.formattedCbm),
          _Row(label: Trans.weight.trans(), value: item.formattedWeight),
          _Row(label: Trans.date.trans(), value: item.formattedCreatedDate),
          _Row(label: Trans.status.trans(), value: item.formattedStatus),
          if (!checkIsNull(item.description))
            _Row(label: Trans.note.trans(), value: item.description ?? ""),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label: ",
              style: context.style14W400B,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.style14W400B.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
