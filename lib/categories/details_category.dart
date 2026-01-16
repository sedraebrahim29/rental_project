import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/details_cubit/details_cubit.dart';
import 'package:rent/cubit/details_cubit/details_state.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/property_model.dart';
import 'package:rent/widgets/details_widgets/details_image.dart';
import 'package:rent/widgets/details_widgets/details_info.dart';

class DetailsCategory extends StatefulWidget {
  const DetailsCategory({
    super.key,
    required this.apartmentId,
  });

  final int apartmentId;

  @override
  State<DetailsCategory> createState() => _DetailsCategoryState();
}

class _DetailsCategoryState extends State<DetailsCategory> {

  void _loadDetails() {
    final lang =context.read<LanguageCubit>().state.languageCode;
    context.read<DetailsCubit>().getDetails(widget.apartmentId, lang);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    return Scaffold(
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DetailsError) {
            return Center(
              child: ElevatedButton.icon(
                onPressed: _loadDetails,
                icon: const Icon(Icons.refresh),
                label:  Text(t.try_again),
              ),
            );
          }

          if (state is DetailsSuccess) {
            final apartment = state.apartment;

            return Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/details_page_1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsImage(
                            images: apartment.imageUrls.isNotEmpty
                                ? apartment.imageUrls
                                : const [
                              'assets/Screenshot 2025-11-01 234119.png',
                              'assets/Screenshot 2025-11-01 234119.png',
                              'assets/Screenshot 2025-11-01 234119.png',
                              'assets/Screenshot 2025-11-01 234119.png',
                            ],
                          ),
                          const SizedBox(height: 100),
                          DetailsInfo(apartment: apartment),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

