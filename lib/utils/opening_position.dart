/// Conversion between the two ways this app talks about "where an opening sits
/// along a wall". They are different quantities and mixing them up shifts a
/// door by half its width, so every conversion goes through here.
///
///  - The **API / geometry** side ([RoomOpening.position], the backend's
///    `WallElement.position`) is the opening's **CENTRE**, as a 0..1 fraction
///    of the wall length. The LiDAR converter writes a centre because it
///    projects the scanned surface's centre onto the wall, and the server's
///    smeta and auto-electrical readers assume a centre.
///  - The **measuring UI** side ([WallOpening.offset]) is the opening's
///    **LEFT EDGE** in metres — that is what the user types under
///    "chapdan" and what the wall painter feeds to `Rect.fromLTWH`.
library;

/// API centre fraction → measuring-UI left-edge offset, in metres.
///
/// May return a negative offset for an opening flush against a corner. That is
/// truthful: clamping it to zero would silently slide the opening inward and
/// disagree with what the scan measured.
double centreFractionToLeftEdgeM({
  required double position,
  required double wallLengthM,
  required double widthM,
}) =>
    position * wallLengthM - widthM / 2;

/// Measuring-UI left-edge offset → API centre fraction, clamped to 0..1.
///
/// A zero-length wall has no meaningful fraction; 0.5 (centred) matches the
/// default the rest of the stack uses for an unplaced opening.
double leftEdgeToCentreFraction({
  required double offsetM,
  required double wallLengthM,
  required double widthM,
}) =>
    wallLengthM == 0
        ? 0.5
        : ((offsetM + widthM / 2) / wallLengthM).clamp(0.0, 1.0);
