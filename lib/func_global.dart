class FunctionGlobal {
  getGMTbySystem() {
    var currentTime = DateTime.now();
    var timeZone = currentTime.timeZoneOffset;
    var end = ":";
    final endIdx = timeZone.toString().indexOf(end);
    var gmt = int.parse(timeZone.toString().substring(0, endIdx));
    return gmt;
  }
}
