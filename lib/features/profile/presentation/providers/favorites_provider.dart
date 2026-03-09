import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/profile/data/datasources/profile_firebase_datasource.dart';

final favoriteIdsProvider =
    FutureProvider<Set<int>>((ref) => ProfileFirebaseDatasource.getFavoriteIds());
