import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/common.dart';
import 'package:untitled/common/localization.dart';
import 'package:untitled/provider/localizationsprovider.dart';
class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          icon: const Icon(Icons.flag),
            items: AppLocalizations.supportedLocales.map((Locale locale){
            final flag = Localization.getFlag(locale.languageCode );
              return DropdownMenuItem(
                value:locale,
                child: Center(child:Text(flag),
                ),
                  onTap: (){
                    final provider = Provider.of<LocalizationsProvider>(context,listen:false);
                    provider.setLocale(locale);
                  }
              );
          }).toList(), onChanged: (_) {  },
           )
    );
  }
}
