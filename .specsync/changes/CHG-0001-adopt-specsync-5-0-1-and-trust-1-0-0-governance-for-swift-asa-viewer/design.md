---
change: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-asa-viewer
artifact: design
---

# Design

Keep macOS CI and DocC Pages unchanged. Add a macOS Trust job that installs SwiftLint and runs the same lint, iOS build, dynamically selected simulator tests, and live Pera API boundary. Use standard Trust with blocking risk, soft provenance, advisory threshold 0, and managed Atlas disabled.

