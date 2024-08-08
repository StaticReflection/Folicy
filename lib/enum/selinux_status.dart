enum SELinuxStatus {
  enforcing(key: 'Enforcing'),
  permissive(key: 'Permissive'),
  disabled(key: 'Disabled'),
  unknown(key: 'Unknown');

  final String key;

  const SELinuxStatus({required this.key});

  static SELinuxStatus fromKey(String key) {
    return SELinuxStatus.values.firstWhere(
      (status) => status.key == key,
      orElse: () => SELinuxStatus.unknown,
    );
  }
}
