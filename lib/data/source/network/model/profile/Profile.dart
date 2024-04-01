class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.address,
    required this.status,
    required this.leaveAllocated,
    required this.employmentType,
    required this.userType,
    required this.officeTime,
    required this.branch,
    required this.department,
    required this.post,
    required this.role,
    required this.avatar,
    required this.joiningDate,
    required this.bankName,
    required this.bankAccountNo,
    required this.bankAccountType,
  });

  factory Profile.fromJson(dynamic json) {
    return Profile(
      id: json['id'],
      name: json['name'].todynamic() ?? "",
      email: json['email'].todynamic() ?? "",
      username: json['username'].todynamic() ?? "",
      phone: json['phone'].todynamic() ?? "",
      dob: json['dob'].todynamic() ?? "",
      gender: json['gender'].todynamic() ?? "",
      address: json['address'].todynamic() ?? "",
      status: json['status'].todynamic() ?? "",
      leaveAllocated: json['leave_allocated'].todynamic() ?? "",
      employmentType: json['employment_type'].todynamic() ?? "",
      userType: json['user_type'].todynamic() ?? "",
      officeTime: json['office_time'].todynamic() ?? "",
      branch: json['branch'].todynamic() ?? "",
      department: json['department'].todynamic() ?? "",
      post: json['post'].todynamic() ?? "",
      role: json['role'].todynamic() ?? "",
      avatar: json['avatar'].todynamic() ?? "",
      joiningDate: json['joining_date'].todynamic() ?? "",
      bankName: json['bank_name'].todynamic() ?? "",
      bankAccountNo: json['bank_account_no'].todynamic() ?? "",
      bankAccountType: json['bank_account_type'].todynamic() ?? "",
    );
  }

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic username;
  dynamic phone;
  dynamic dob;
  dynamic gender;
  dynamic address;
  dynamic status;
  dynamic leaveAllocated;
  dynamic employmentType;
  dynamic userType;
  dynamic officeTime;
  dynamic branch;
  dynamic department;
  dynamic post;
  dynamic role;
  dynamic avatar;
  dynamic joiningDate;
  dynamic bankName;
  dynamic bankAccountNo;
  dynamic bankAccountType;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['phone'] = phone;
    map['dob'] = dob;
    map['gender'] = gender;
    map['address'] = address;
    map['status'] = status;
    map['leave_allocated'] = leaveAllocated;
    map['employment_type'] = employmentType;
    map['user_type'] = userType;
    map['office_time'] = officeTime;
    map['branch'] = branch;
    map['department'] = department;
    map['post'] = post;
    map['role'] = role;
    map['avatar'] = avatar;
    map['joining_date'] = joiningDate;
    map['bank_name'] = bankName;
    map['bank_account_no'] = bankAccountNo;
    map['bank_account_type'] = bankAccountType;
    return map;
  }
}
