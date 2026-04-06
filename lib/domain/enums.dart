/// Domain enums shared across data and presentation layers.
///
/// These are business concepts — not persistence details.
/// The data layer uses them in Drift table definitions; the presentation
/// layer uses them for display and filtering.

enum ClientStatus { active, inactive, pending }

enum Sex { male, female }

enum PhysicalActivity {
  sedentary,
  light,
  moderate,
  active,
  veryActive,
}
