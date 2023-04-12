import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_app/controllers/bluetooth_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BluetoothController>(
          init: BluetoothController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20 * 3),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.scanDevices();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(350, 55),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Text(
                        'Scan',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<ScanResult>>(
                    stream: controller.scanResults,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final device = snapshot.data![index].device;
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                onTap: () {},
                                title: Text(device.name),
                                subtitle: Text(device.id.id),
                                trailing: TextButton(
                                  onPressed: () {
                                    controller.connectToDevice(device);
                                  },
                                  child: Text(BluetoothDeviceState.connected ==
                                          device.state
                                      ? 'Connected'
                                      : 'Connect'),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No devices found'),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
