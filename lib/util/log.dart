const isDebugger = true;

// 系统开发打印
void log(String msg) {
  if (isDebugger) print('${DateTime.now()} => $msg');
}