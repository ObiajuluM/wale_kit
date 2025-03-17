import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:wale_kit/chan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ReownAppKitModal _appKitModal;
  @override
  void initState() {
    super.initState();

    _appKitModal = ReownAppKitModal(
      context: context,
      projectId: '288fbb58ea9790bde773e949a76092c3', //
      metadata: const PairingMetadata(
        name: 'Example App',
        description: 'Example app description',
        url: 'https://reown.com/',
        icons: ['https://reown.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp://',
          universal: 'https://reown.com/exampleapp',
        ),
      ),
    );

    _appKitModal.init().then((value) => setState(() {}));
  }

  void doIt() async {
// AppKit instance
    final appKit = await ReownAppKit.createInstance(
      projectId: '288fbb58ea9790bde773e949a76092c3',
      metadata: const PairingMetadata(
        name: 'Example App',
        description: 'Example app description',
        url: 'https://example.com/',
        icons: ['https://example.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp://',
          universal: 'https://reown.com/exampleapp',
          linkMode: true | false,
        ),
      ),
    );

// AppKit Modal instance
    final _appKitModal = ReownAppKitModal(
      context: context,
      appKit: appKit,
    );

// Register here the event callbacks on the service you'd like to use. See `Events` section.

    await _appKitModal.init();

    DeepLinkHandler.init(_appKitModal);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      print("object");
      doIt();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppKitModalNetworkSelectButton(
              appKit: _appKitModal,
              context: context,
            ),
            AppKitModalConnectButton(
              appKit: _appKitModal,
              context: context,
            ),
            Visibility(
              visible: _appKitModal.isConnected,
              child: AppKitModalAccountButton(
                appKit: _appKitModal,
                appKitModal: _appKitModal,
                context: context,
              ),
            )
          ],
        ),
      ),
    );
  }
}
