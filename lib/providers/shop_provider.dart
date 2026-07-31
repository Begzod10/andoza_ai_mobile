import 'package:riverpod/riverpod.dart';
import '../models/design_selection_model.dart';
import '../models/electrical_model.dart';
import '../models/shop_model.dart';
import 'design_provider.dart';
import 'electrical_provider.dart';
import 'room_provider.dart';

/// Real project floor/wall area, falling back to a typical single-room
/// baseline when the user hasn't gone through Batch A yet — same
/// semantic-default rationale as home_empty_screen.dart's [ProjectItem].
class _ProjectAreas {
  const _ProjectAreas({required this.floorArea, required this.wallArea});

  final double floorArea;
  final double wallArea;
}

_ProjectAreas _computeAreas(Ref ref) {
  final room = ref.watch(activeRoomProvider);
  if (room == null) {
    return const _ProjectAreas(floorArea: 18.0, wallArea: 48.0);
  }
  final floorArea = room.dimensions.width * room.dimensions.length;
  final wallArea = room.walls.fold<double>(
    0,
    (sum, w) => sum + w.measurements.height * w.measurements.length,
  );
  return _ProjectAreas(
    floorArea: floorArea > 0 ? floorArea : 18.0,
    wallArea: wallArea > 0 ? wallArea : 48.0,
  );
}

bool _stageExcluded(Ref ref, RenovationStage stage) {
  final design = ref.watch(activeDesignProvider);
  final condition = design?.roomCondition;
  if (condition == null) return false;
  final states = deriveStageStates(
    condition: condition,
    currentStage: design?.renovationStage ?? RenovationStage.suvoq,
  );
  return states[stage.index] == StageDisplayState.excluded;
}

class _ElectricalNeed {
  const _ElectricalNeed({required this.outletCount, required this.wireMeters});

  final int outletCount;
  final double wireMeters;
}

_ElectricalNeed _computeElectricalNeed(Ref ref) {
  final layout = ref.watch(electricalLayoutProvider);
  if (layout == null || layout.devices.isEmpty) {
    return const _ElectricalNeed(outletCount: 8, wireMeters: 72.0);
  }
  final outletCount = layout.devices
      .where((d) => d.type == DeviceType.outlet)
      .length;
  final wireMeters = computeTotalWireLengthMeters(layout);
  return _ElectricalNeed(
    outletCount: outletCount > 0 ? outletCount : 8,
    wireMeters: wireMeters > 0 ? wireMeters : 72.0,
  );
}

/// The full Do'kon catalog, with [Product.projectQuantity] computed from
/// real room/design/electrical state wherever the spec ties a category to
/// the active renovation stage (delta mechanic: excluded stages need no
/// material, so their products carry no project quantity).
final shopCatalogProvider = Provider<List<Product>>((ref) {
  final areas = _computeAreas(ref);
  final electrical = _computeElectricalNeed(ref);

  final shpaklovkaNeeded = !_stageExcluded(ref, RenovationStage.shpaklovka);
  final boyoqOboiNeeded = !_stageExcluded(ref, RenovationStage.boyoqOboi);
  final polNeeded = !_stageExcluded(ref, RenovationStage.pol);

  return [
    Product(
      id: 'vetonit',
      name: 'Vetonit shpaklovka',
      brand: 'Vetonit',
      category: ShopCategory.gips,
      pricePerUnit: 68000,
      unit: 'qop',
      isOfficialDealer: true,
      coverage: '1 qop ≈ 6 m²',
      dryingTime: '24 soat',
      projectQuantity: shpaklovkaNeeded
          ? (areas.wallArea / 6).ceilToDouble()
          : null,
    ),
    Product(
      id: 'vinil_oboy',
      name: 'Vinil devor qog\'ozi',
      brand: 'Palitra',
      category: ShopCategory.oboy,
      pricePerUnit: 145000,
      unit: 'rulon',
      isOfficialDealer: true,
      coverage: '1 rulon ≈ 5 m²',
      washable: true,
      projectQuantity: boyoqOboiNeeded
          ? (areas.wallArea / 5).ceilToDouble()
          : null,
    ),
    Product(
      id: 'akril_boyoq',
      name: 'Akril devor bo\'yog\'i',
      brand: 'Tex Color',
      category: ShopCategory.boyoq,
      pricePerUnit: 45000,
      unit: 'L',
      isOfficialDealer: true,
      coverage: '1 L ≈ 5 m², 2 qatlam',
      dryingTime: '4 soat',
      washable: true,
      projectQuantity: boyoqOboiNeeded
          ? double.parse((areas.wallArea * 0.2).toStringAsFixed(1))
          : null,
    ),
    Product(
      id: 'laminat',
      name: 'Laminat pol qoplamasi',
      brand: 'Quick-Step',
      category: ShopCategory.laminat,
      pricePerUnit: 118000,
      unit: 'm²',
      isOfficialDealer: true,
      coverage: '10% zaxira bilan',
      projectQuantity: polNeeded
          ? double.parse((areas.floorArea * 1.1).toStringAsFixed(1))
          : null,
    ),
    Product(
      id: 'podloshka',
      name: 'Podloshka (izolyatsiya)',
      brand: 'Tuplex',
      category: ShopCategory.laminat,
      pricePerUnit: 22000,
      unit: 'm²',
      isOfficialDealer: false,
      projectQuantity: polNeeded
          ? double.parse(areas.floorArea.toStringAsFixed(1))
          : null,
    ),
    Product(
      id: 'kafel',
      name: 'Keramik kafel',
      brand: 'Kerama Marazzi',
      category: ShopCategory.kafel,
      pricePerUnit: 96000,
      unit: 'm²',
      isOfficialDealer: true,
      coverage: 'Hammomlar uchun',
    ),
    Product(
      id: 'parket',
      name: 'Massiv parket',
      brand: 'Tarkett',
      category: ShopCategory.parket,
      pricePerUnit: 210000,
      unit: 'm²',
      isOfficialDealer: true,
    ),
    Product(
      id: 'sement',
      name: 'Sement M400',
      brand: 'Qizilqum Sement',
      category: ShopCategory.sement,
      pricePerUnit: 38000,
      unit: 'qop',
      isOfficialDealer: false,
    ),
    Product(
      id: 'rozetka',
      name: 'Rozetka (o\'rnatilgan)',
      brand: 'Schneider Electric',
      category: ShopCategory.elektr,
      pricePerUnit: 34000,
      unit: 'dona',
      isOfficialDealer: true,
      projectQuantity: double.parse(electrical.outletCount.toStringAsFixed(0)),
    ),
    Product(
      id: 'kabel',
      name: 'Elektr kabeli VVG 3x2.5',
      brand: 'Uzkabel',
      category: ShopCategory.elektr,
      pricePerUnit: 9500,
      unit: 'm',
      isOfficialDealer: true,
      projectQuantity: double.parse(electrical.wireMeters.toStringAsFixed(1)),
    ),
    Product(
      id: 'santexnika_set',
      name: 'Aralashtirgich to\'plami',
      brand: 'Grohe',
      category: ShopCategory.santexnika,
      pricePerUnit: 780000,
      unit: 'dona',
      isOfficialDealer: true,
    ),
  ];
});

/// S2's grouped-by-stage list — only stages with a real (non-null)
/// project quantity for at least one product appear, so a stage the
/// room's starting condition already excludes never shows up here.
final projectMaterialsProvider = Provider<List<StageMaterialGroup>>((ref) {
  final catalog = ref.watch(shopCatalogProvider);
  Product? byId(String id) => catalog.where((p) => p.id == id).firstOrNull;

  final groups = <StageMaterialGroup>[];

  final shpaklovka = byId('vetonit');
  if (shpaklovka?.projectQuantity != null) {
    groups.add(
      StageMaterialGroup(
        stageLabel: 'Shpaklovka',
        items: [
          StageMaterialItem(
            name: shpaklovka!.name,
            quantity: shpaklovka.projectQuantity!,
            unit: shpaklovka.unit,
          ),
        ],
      ),
    );
  }

  final oboy = byId('vinil_oboy');
  final boyoq = byId('akril_boyoq');
  final boyoqOboiItems = [
    if (oboy?.projectQuantity != null)
      StageMaterialItem(
        name: oboy!.name,
        quantity: oboy.projectQuantity!,
        unit: oboy.unit,
      ),
    if (boyoq?.projectQuantity != null)
      StageMaterialItem(
        name: boyoq!.name,
        quantity: boyoq.projectQuantity!,
        unit: boyoq.unit,
      ),
  ];
  if (boyoqOboiItems.isNotEmpty) {
    groups.add(
      StageMaterialGroup(stageLabel: 'Bo\'yoq/Oboy', items: boyoqOboiItems),
    );
  }

  final laminat = byId('laminat');
  final podloshka = byId('podloshka');
  final polItems = [
    if (laminat?.projectQuantity != null)
      StageMaterialItem(
        name: laminat!.name,
        quantity: laminat.projectQuantity!,
        unit: laminat.unit,
      ),
    if (podloshka?.projectQuantity != null)
      StageMaterialItem(
        name: podloshka!.name,
        quantity: podloshka.projectQuantity!,
        unit: podloshka.unit,
      ),
  ];
  if (polItems.isNotEmpty) {
    groups.add(StageMaterialGroup(stageLabel: 'Pol', items: polItems));
  }

  final rozetka = byId('rozetka');
  final kabel = byId('kabel');
  groups.add(
    StageMaterialGroup(
      stageLabel: 'Elektr',
      items: [
        StageMaterialItem(
          name: rozetka!.name,
          quantity: rozetka.projectQuantity!,
          unit: rozetka.unit,
        ),
        StageMaterialItem(
          name: kabel!.name,
          quantity: kabel.projectQuantity!,
          unit: kabel.unit,
        ),
      ],
    ),
  );

  return groups;
});

/// Total floor area covered by the active project's materials, shown in
/// S2's green banner ("34.6 m², 4 bosqich").
final projectMaterialsSummaryProvider = Provider<(double area, int stages)>((
  ref,
) {
  final areas = _computeAreas(ref);
  final groups = ref.watch(projectMaterialsProvider);
  return (areas.floorArea, groups.length);
});

/// Deterministic mock dealer offers per product — varied price/delivery so
/// S4's "ENG YAXSHI" (cheapest + fastest wins ties) has a real winner.
List<Dealer> dealersForProduct(Product product) {
  final base = product.pricePerUnit;
  final seed = product.id.hashCode;
  return [
    Dealer(
      id: '${product.id}_official',
      name: '${product.brand} Rasmiy do\'kon',
      isOfficial: true,
      district: 'Chilonzor',
      deliveryDays: 2,
      pricePerUnit: base,
    ),
    Dealer(
      id: '${product.id}_market',
      name: 'Qurilish Bozori',
      isOfficial: false,
      district: 'Sergeli',
      deliveryDays: 1,
      pricePerUnit: base - (base * 0.08).round() + (seed % 7) * 100,
    ),
    Dealer(
      id: '${product.id}_online',
      name: 'UzMall',
      isOfficial: false,
      district: 'Yunusobod',
      deliveryDays: 4,
      pricePerUnit: base + (base * 0.05).round(),
    ),
  ];
}

/// Best dealer per the spec's S4 rule: cheapest wins; official dealer
/// breaks ties in a way that favors trust over a marginal discount.
Dealer bestDealer(List<Dealer> dealers) {
  final sorted = [...dealers]
    ..sort((a, b) => a.pricePerUnit.compareTo(b.pricePerUnit));
  return sorted.first;
}
