import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:starflut/starflut.dart';

class Backend {
  String _platformVersion = 'Unknown';

  // Platform messages are asynchronous, so we initialize in an async method.
  static Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      StarCoreFactory starcore = await Starflut.getFactory();
      StarServiceClass service = await starcore.initSimple("test", "123", 0, 0, []);
      await starcore
          .regMsgCallBackP((int serviceGroupID, int uMsg, Object wParam, Object lParam) async {
        print("$serviceGroupID  $uMsg   $wParam   $lParam");

        return null;
      });
      StarSrvGroupClass srvGroup = await service["_ServiceGroup"] as StarSrvGroupClass; //////

      /*---script python--*/
      bool isAndroid = await Starflut.isAndroid();
      if (isAndroid == true) {
        await Starflut.copyFileFromAssets(
            "testcallback.py", "flutter_assets/starfiles", "flutter_assets/starfiles");
        await Starflut.copyFileFromAssets(
            "testpy.py", "flutter_assets/starfiles", "flutter_assets/starfiles");
        await Starflut.copyFileFromAssets(
            "python3.6.zip", "flutter_assets/starfiles", null); //desRelatePath must be null
        await Starflut.copyFileFromAssets("zlib.cpython-36m.so", null, null);
        await Starflut.copyFileFromAssets("unicodedata.cpython-36m.so", null, null);
        await Starflut.loadLibrary("libpython3.6m.so");
      }

      String docPath = await Starflut.getDocumentPath();
      print("docPath = $docPath");
      String resPath = await Starflut.getResourcePath();
      print("resPath = $resPath");
      dynamic rr1 = await srvGroup.initRaw("python36", service);

      print("initRaw = $rr1");
      var result = await srvGroup.loadRawModule(
          "python", "", resPath + "/flutter_assets/starfiles/" + "testpy.py", false);
      print("loadRawModule = $result");
      dynamic python = await service.importRawContext("python", "", "", false,"");
      print("python = " + await python.getString());
      StarObjectClass retobj = await python.call("tt", ["hello ", "world"]);
      print(await retobj[0]);
      print(await retobj[1]);
      print(await python["g1"]);
      StarObjectClass yy = await python.call("yy", ["hello ", "world", 123]);
      print(await yy.call("__len__", []));
      StarObjectClass multiply = await service.importRawContext("python", "Multiply", "", true,"");
      StarObjectClass multiply_inst = await multiply.newObject(["", "", 33, 44]);
      print(await multiply_inst.getString());
      print(await multiply_inst.call("multiply", [11, 22]));
      await srvGroup.clearService();
      await starcore.moduleExit();
      platformVersion = 'Python 3.6';
    } on PlatformException catch (e) {
      print("{$e.message}");
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    // if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }
}