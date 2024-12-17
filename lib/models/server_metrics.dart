class ServerMetrics {
  final String health;
  final String uptime;
  final int activeConnections;
  final double cpuUsage;
  final double memoryUsage;
  final double diskUsage;
  final int requestsPerMinute;
  final double responseTime;
  final Map<String, dynamic> errorRates;

  ServerMetrics.fromJson(Map<String, dynamic> json)
      : health = json['health'] ?? 'Unknown',
        uptime = json['uptime'] ?? 'N/A',
        activeConnections = json['active_connections'] ?? 0,
        cpuUsage = (json['cpu_usage'] ?? 0.0).toDouble(),
        memoryUsage = (json['memory_usage'] ?? 0.0).toDouble(),
        diskUsage = (json['disk_usage'] ?? 0.0).toDouble(),
        requestsPerMinute = json['requests_per_minute'] ?? 0,
        responseTime = (json['response_time'] ?? 0.0).toDouble(),
        errorRates = json['error_rates'] ?? {};
}
