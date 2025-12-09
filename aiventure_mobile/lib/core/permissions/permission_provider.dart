import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

abstract class IPermissionService {
  Future<bool> requestCamera();
  Future<bool> requestPhotos();
  Future<bool> requestLocation();
}

class MockPermissionService implements IPermissionService {
  const MockPermissionService();

  @override
  Future<bool> requestCamera() async => true;

  @override
  Future<bool> requestPhotos() async => true;

  @override
  Future<bool> requestLocation() async => true;
}

class RealPermissionService implements IPermissionService {
  const RealPermissionService();

  // For now, optimistic: return true. In future, integrate permission_handler.
  @override
  Future<bool> requestCamera() async => true;

  @override
  Future<bool> requestPhotos() async => true;

  @override
  Future<bool> requestLocation() async => true;
}

final permissionServiceProvider = Provider<IPermissionService>((ref) {
  final useMock = ref.watch(useMockBackendProvider);
  if (useMock) return const MockPermissionService();
  return const RealPermissionService();
});
