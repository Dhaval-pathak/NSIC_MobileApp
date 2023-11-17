String getUnitCategory(String unit) {
  if (unit.trim() == "Micro") {
    return "3";
  } else if (unit.trim() == "Small") {
    return "4";
  } else {
    return "0";
  }
}

String getSocialCat(String cat) {
  if (cat.trim().toUpperCase() == "GENERAL") {
    return "1";
  } else if (cat.trim().toUpperCase() == "OBC") {
    return "5";
  } else if (cat.trim().toUpperCase() == "SC") {
    return "10";
  } else if (cat.trim().toUpperCase() == "ST") {
    return "11";
  } else {
    return "0";
  }
}

String getEntrepreneurType(
    {required String pwd,
    required String woman,
    required String minority,
    required String exservice})
{
  if (pwd == "True") {
    return "8";
  } else if (woman == "True") {
    return "6";
  } else if (minority == "True") {
    return "9";
  } else if (exservice == "True") {
    return "7";
  } else {
    return "1";
  }
}

String getConstitution(String constitution){
  if (constitution == "Proprietary") {
    return "4";
  } else if (constitution == "Limited Liability Partnership") {
    return "4";
  } else if (constitution == "Partnership") {
    return "5";
  } else if (constitution == "Public Limited Company") {
    return "6";
  } else if (constitution == "Private Limited Company") {
    return "7";
  } else if (constitution == "Hindu Undivided Family") {
    return "9";
  } else if (constitution == "Co-Operative") {
    return "8";
  } else if (constitution == "Society") {
    return "8";
  } else if (constitution == "Trust") {
    return "11";
  } else{
    return "0";
  }
}
