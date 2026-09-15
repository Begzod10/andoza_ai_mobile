import XCTest

@testable import Runner

/// Covers the pure measurement math in `RoomMeasurer` — the part that decides
/// the width / length / height handed back to Dart. The ARKit adapter
/// (`ingest`) needs a live session and is exercised on device instead.
final class RoomMeasurerTests: XCTestCase {

  func testStartsEmpty() {
    let measurer = RoomMeasurer()
    XCTAssertEqual(measurer.width, 0)
    XCTAssertEqual(measurer.length, 0)
    XCTAssertEqual(measurer.height, 0)
    XCTAssertEqual(measurer.pointCount, 0)
  }

  func testLargestHorizontalPlaneWins() {
    let measurer = RoomMeasurer()
    measurer.addHorizontalPlane(extentX: 2.0, extentZ: 1.5)  // area 3.0
    measurer.addHorizontalPlane(extentX: 4.0, extentZ: 3.0)  // area 12.0 — floor
    measurer.addHorizontalPlane(extentX: 1.0, extentZ: 1.0)  // area 1.0 — a table

    XCTAssertEqual(measurer.width, 4.0, accuracy: 1e-6)
    XCTAssertEqual(measurer.length, 3.0, accuracy: 1e-6)
  }

  func testTallestVerticalPlaneBecomesHeight() {
    let measurer = RoomMeasurer()
    measurer.addVerticalPlane(verticalExtent: 1.2)
    measurer.addVerticalPlane(verticalExtent: 2.55)
    measurer.addVerticalPlane(verticalExtent: 0.9)

    XCTAssertEqual(measurer.finalizedHeight(), 2.55, accuracy: 1e-6)
  }

  func testHeightFallsBackToDefaultWhenNoVerticalPlaneSeen() {
    let measurer = RoomMeasurer()
    measurer.addHorizontalPlane(extentX: 3.0, extentZ: 4.0)

    XCTAssertEqual(measurer.height, 0)
    XCTAssertEqual(measurer.finalizedHeight(), RoomMeasurer.defaultHeight, accuracy: 1e-6)
  }

  func testPointCountAccumulates() {
    let measurer = RoomMeasurer()
    measurer.addPoints(count: 120)
    measurer.addPoints(count: 80)

    XCTAssertEqual(measurer.pointCount, 200)
  }
}
