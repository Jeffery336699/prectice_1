import 'dart:async';

void main() async {
  // async wait
//  getName1();
//  getName2();
//  getName3();

  //then catchError whenComplete
//  new Future(() => futureTask()) //  异步任务的函数
//      .then((m) => "a:$m") //   任务执行完后的子任务
//      .then((m) => print('a$m')) //  其中m为上个任务执行完后的返回的结果
//      .then((_) => new Future.error('error'))
//      .then((m) => print('damon'))
//      .whenComplete(() => print('whenComplete1')) //不是最后执行whenComplete，通常放到最后回调
//
////      .catchError((e) => print(e))//如果不写test默认实现一个返回true的test方法
//      .catchError((e) => print('catchError:' + e), test: (Object o) {
//        print('test:' + o);
//        return true; //返回true，会被catchError捕获
////        return false; //返回false，继续抛出错误，会被下一个catchError捕获
//      })
//      .catchError((e) => print('catchError2:' + e))//这是下一个catchError
//      .then((m) => print('dongnao'))
//      .whenComplete(() => print('finish'))
// ;

  // Future
//  testFuture();

  //scheduleMicrotask
  testScheduleMicrotask();
}

//then catchError whenComplete
int futureTask() {
  throw 'error futureTask';
//  return 0;
}

void printLength(int length) {
  print("Text Length:$length");
}

// async wait
Future<void> getName1() async {
  await getStr1(); //遇到第一个await表达式执行暂停，返回future对象，await表达式执行完成后继续执行
  await getStr2(); //await表达式可以使用多次
  print('getName1');


}

 getStr1() {
  ///如果遇到这种Future情况,立马会执行main中的
  Future.delayed(Duration(seconds: 0),(){
    print('getStr1');
  });
   Future.value(1).then((value){
     print('getStr1');
   });
//  print('getStr1');
}

getStr2() {
  print('getStr2');
}

getName2() {
  print('getName2');
}

getName3() {
  print('getName3');
}

//Future delayed
void testFuture() {//7 1 3  2   4  11   6  5
  Future f =  Future(() => print("f1"));
  Future f1 = new Future.delayed(Duration(seconds: 1) ,() => print("f8"));//7 1 3 9 2 4 8 6 5
  Future f2 =  Future(() => null);
  Future f3 =  Future(() => null);

  f3.then((_) => print("f2"));
  f2.then((_) {
    print("f3");
    new Future(() => print("f4"));
    f1.then((_) {
      print("f5");
    });
    print("f9");
  });

  f1.then((m) {
    print("f6");
  });
  print("f7");
}

//scheduleMicrotask
void testScheduleMicrotask() {
  //9 1 8  3  4  6  5  10  7  11  12   2
  scheduleMicrotask(() => print('s1'));

  new Future.delayed(new Duration(seconds: 1), () => print('s2'));

  new Future(() => print('s3')).then((_) {
    print('s4');
    scheduleMicrotask(() => print('s5'));
  }).then((_) => print('s6'));

  new Future(() => print('s10'))
      .then((_) => new Future(() => print('s11')))
      .then((_) => print('s12'));

  new Future(() => print('s7'));

  scheduleMicrotask(() => print('s8'));

  print('s9');
}
