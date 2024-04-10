// RUN: %target-swift-frontend -primary-file %s -target %target-cpu-apple-macosx10.14 -enable-experimental-feature DynamicActorIsolation -emit-silgen -o - | %FileCheck %s

// REQUIRES: asserts
// REQUIRES: concurrency
// REQUIRES: OS=macosx

protocol P {
  associatedtype T

  func fn() -> T?
}

@MainActor
struct IsolatedType<T> : @preconcurrency P {
  func fn() -> T? { nil }
}

// CHECK-LABEL: sil private [transparent] [thunk] [ossa] @$s38preconcurrency_conformances_backdeploy12IsolatedTypeVyxGAA1PA2aEP2fn1TQzSgyFTW
// CHECK-NOT: function_ref @$sScM6sharedScMvgZ
// CHECK-NOT: function_ref @$ss22_checkExpectedExecutor14_filenameStart01_D6Length01_D7IsASCII5_line9_executoryBp_BwBi1_BwBetF
