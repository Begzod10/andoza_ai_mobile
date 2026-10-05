import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../models/business_profile.dart';
import '../../providers/business_provider.dart';

/// Edit the shop's own public profile. Moderation status is not the owner's to change.
class EditShopScreen extends ConsumerStatefulWidget {
  const EditShopScreen({super.key});

  @override
  ConsumerState<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends ConsumerState<EditShopScreen> {
  final _name = TextEditingController();
  final _district = TextEditingController();
  final _phone = TextEditingController();
  final _telegram = TextEditingController();
  bool _loaded = false;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    for (final c in [_name, _district, _phone, _telegram]) {
      c.dispose();
    }
    super.dispose();
  }

  void _fill(ShopProfile s) {
    _loaded = true;
    _name.text = s.name;
    _district.text = s.district ?? '';
    _phone.text = s.phone ?? '';
    _telegram.text = s.telegram ?? '';
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final router = GoRouter.of(context);
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(businessRepositoryProvider).updateShop(
            name: _name.text,
            district: _district.text.trim(),
            phone: _phone.text,
            telegram: _telegram.text.trim(),
          );
      ref.invalidate(myShopProvider);
      router.pop();
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = l10n.ustaEditFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final shop = ref.watch(myShopProvider);
    if (!_loaded && shop.valueOrNull != null) _fill(shop.value!);
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(l10n.shopEditTitle, style: DesignTokens.heading3),
      ),
      body: !_loaded
          ? Center(
              child: shop.hasError ? Text(l10n.businessLoadFailed) : const CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
              children: [
                TextField(controller: _name, decoration: InputDecoration(labelText: l10n.businessFieldShopName)),
                const SizedBox(height: DesignTokens.spacingSm),
                TextField(controller: _district, decoration: InputDecoration(labelText: l10n.businessFieldDistrict)),
                const SizedBox(height: DesignTokens.spacingSm),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: l10n.businessFieldPhone),
                ),
                const SizedBox(height: DesignTokens.spacingSm),
                TextField(controller: _telegram, decoration: InputDecoration(labelText: l10n.businessFieldTelegram)),
                const SizedBox(height: DesignTokens.spacingMd),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: DesignTokens.spacingSm),
                    child: Text(_error!, style: DesignTokens.body2.copyWith(color: DesignTokens.errorRed)),
                  ),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  child: Text(l10n.ustaEditSave),
                ),
              ],
            ),
    );
  }
}
