import 'attachment.dart';

class Tada {
  int id;
  String title;
  String? description;
  String expenses;
  String status;
  String? remark;
  String? verifiedBy;
  String? submittedDate;
  List<Attachment>? attachments;

  Tada(this.id, this.title, this.description, this.expenses, this.status,
      this.remark, this.verifiedBy, this.submittedDate, this.attachments);

  Tada.list(this.id, this.title, this.expenses, this.status, this.remark,
      this.submittedDate);
}
