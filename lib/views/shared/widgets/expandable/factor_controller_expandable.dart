part of 'factor_expandable.dart';

class FactorExpandableController extends ValueNotifier<bool> {
  FactorExpandableController(bool expanded) : super(expanded);

  bool get expanded => value;

  set expanded(bool newValue) => value = newValue;

  @override
  set value(bool newValue) => super.value = newValue;

  void toggle() => value = !value;
}
