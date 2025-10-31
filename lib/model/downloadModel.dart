class DownloadModel {
  int? documentId;
  String? documentName;
  String? description;
  String? fileLink;
  String? publishOn;

  DownloadModel(
      {this.documentId,
        this.documentName,
        this.description,
        this.fileLink,
        this.publishOn});

  DownloadModel.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    documentName = json['document_name'];
    description = json['description'];
    fileLink = json['file_link'];
    publishOn = json['publish_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_id'] = this.documentId;
    data['document_name'] = this.documentName;
    data['description'] = this.description;
    data['file_link'] = this.fileLink;
    data['publish_on'] = this.publishOn;
    return data;
  }
}
