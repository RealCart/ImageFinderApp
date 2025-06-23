import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DownloadService {
  static final DownloadService _instance = DownloadService._internal();
  factory DownloadService() => _instance;
  DownloadService._internal();

  final Dio _dio = Dio();

  Future<String?> downloadImage(String imageUrl, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory('${directory.path}/Downloads');

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      final fileExtension = path.extension(imageUrl);
      final finalFileName = '$fileName$fileExtension';
      final filePath = '${downloadsDir.path}/$finalFileName';

      await _dio.download(
        imageUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            print('Download Progress: $progress%');
          }
        },
      );

      return filePath;
    } catch (e) {
      print('Download error: $e');
      return null;
    }
  }
}
