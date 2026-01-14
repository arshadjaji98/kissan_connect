// lib/widgets/crop_selection_widget.dart
import 'package:flutter/material.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';

class CropSelectionWidget extends StatefulWidget {
  final Function(List<String>)? onCropsSelected;
  final List<String>? initialSelectedCrops; // ADD THIS

  const CropSelectionWidget({
    super.key,
    this.onCropsSelected,
    this.initialSelectedCrops, // ADD THIS
  });

  @override
  State<CropSelectionWidget> createState() => _CropSelectionWidgetState();
}

class _CropSelectionWidgetState extends State<CropSelectionWidget> {
  late List<String> _selectedCrops; // Change to late

  @override
  void initState() {
    super.initState();
    // Initialize with initialSelectedCrops if provided, otherwise default to ["Wheat"]
    _selectedCrops = List.from(widget.initialSelectedCrops ?? ["Wheat"]);

    // Ensure at least one crop is always selected
    if (_selectedCrops.isEmpty) {
      _selectedCrops = ["Wheat"];
    }

    // Notify parent about initial selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onCropsSelected != null) {
        widget.onCropsSelected!(_selectedCrops);
      }
    });
  }

  void _toggleCropSelection(String crop) {
    setState(() {
      if (_selectedCrops.contains(crop)) {
        _selectedCrops.remove(crop);
      } else {
        _selectedCrops.add(crop);
      }

      // Ensure at least one crop is always selected
      if (_selectedCrops.isEmpty) {
        _selectedCrops.add("Wheat");
      }

      // Notify parent about selection changes
      if (widget.onCropsSelected != null) {
        widget.onCropsSelected!(_selectedCrops);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _crops = [
      AppLocalizations.of(context)!.wheat,
      AppLocalizations.of(context)!.rice,
      AppLocalizations.of(context)!.cotton,
      AppLocalizations.of(context)!.sugarcane,
      AppLocalizations.of(context)!.maize,
      AppLocalizations.of(context)!.vegetables,
    ];

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Crop selection grid - 3 columns
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: _crops.length,
            itemBuilder: (context, index) {
              final crop = _crops[index];
              final isSelected = _selectedCrops.contains(crop);

              return GestureDetector(
                onTap: () {
                  _toggleCropSelection(crop);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4CAF50) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey[300]!,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      crop,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              AppLocalizations.of(context)!.selectMultipleCrops,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
