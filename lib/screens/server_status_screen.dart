import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mika_app/components/control_panel.dart';
import 'package:mika_app/components/metric_card.dart';
import 'package:mika_app/models/server_metrics.dart';
import 'package:mika_app/components/log_viewer.dart';

class ServerStatusScreen extends StatefulWidget {
  const ServerStatusScreen({super.key});

  @override
  _ServerStatusScreenState createState() => _ServerStatusScreenState();
}

class _ServerStatusScreenState extends State<ServerStatusScreen> {
  ServerMetrics? _metrics;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchServerStatus();
  }

  Future<void> _fetchServerStatus() async {
    try {
      final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));
      setState(() {
        _metrics = ServerMetrics.fromJson(json.decode(response.body));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to fetch server status');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showLogsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: LogViewer(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Server Monitor'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchServerStatus,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchServerStatus,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  MetricCard(
                    title: 'Health',
                    value: _metrics?.health ?? 'Unknown',
                    color: _metrics?.health == 'Healthy'
                        ? Colors.green
                        : Colors.red,
                    icon: Icons.favorite,
                  ),
                  MetricCard(
                    title: 'CPU',
                    value: '${_metrics?.cpuUsage.toStringAsFixed(1)}%',
                    color: Colors.blue,
                    icon: Icons.memory,
                  ),
                  MetricCard(
                    title: 'Memory',
                    value: '${_metrics?.memoryUsage.toStringAsFixed(1)}%',
                    color: Colors.purple,
                    icon: Icons.sd_storage,
                  ),
                  MetricCard(
                    title: 'Disk',
                    value: '${_metrics?.diskUsage.toStringAsFixed(1)}%',
                    color: Colors.orange,
                    icon: Icons.storage,
                  ),
                  MetricCard(
                    title: 'Requests/min',
                    value: '${_metrics?.requestsPerMinute}',
                    color: Colors.teal,
                    icon: Icons.speed,
                  ),
                  MetricCard(
                    title: 'Response Time',
                    value: '${_metrics?.responseTime.toStringAsFixed(2)}ms',
                    color: Colors.indigo,
                    icon: Icons.timer,
                  ),
                ],
              ),
              SizedBox(height: 24),
              ControlPanel(
                onRestart: () async {},
                onBackup: () {},
                onLogs: _showLogsModal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
