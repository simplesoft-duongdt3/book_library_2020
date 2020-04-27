import 'package:meta/meta.dart';

@immutable
abstract class CategoryEvent {}

class GetCategoryItemsEvent extends CategoryEvent {}