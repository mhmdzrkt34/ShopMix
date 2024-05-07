import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;
  bool isAuthenticating = false;
  String authenticationMessage = "Please authenticate using biometrics.";

  @override
  void initState() {
    super.initState();
    checkDeviceSupport();
    checkBiometric();
    getAvailableBiometrics();
  }

  Future<void> checkDeviceSupport() async {
    bool isSupported;
    try {
      isSupported = await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print(e);
      isSupported = false;
    }

    if (!mounted) return;
    setState(() {
      supportState =
          isSupported ? SupportState.supported : SupportState.unsupported;
    });
  }

  Future<void> checkBiometric() async {
    bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometric supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("Supported biometrics: $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
      biometricTypes = [];
    }

    if (!mounted) return;
    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;

    try {
      setState(() {
        isAuthenticating = true;
        authenticationMessage = "Authenticating...";
      });

      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate with fingerprint or Face ID',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        authenticationMessage = "Authentication error: ${e.message}";
      });
      return;
    } finally {
      setState(() {
        isAuthenticating = false;
      });
    }

    if (!mounted) return;

    setState(() {
      if (authenticated) {
        authenticationMessage = "Authentication successful!";
        Navigator.pushReplacementNamed(
            context, "/"); // Replace with your desired route
      } else {
        // If biometric authentication failed, prompt for PIN
        authenticationMessage =
            "Biometric authentication failed. Please enter your PIN.";
        _authenticateWithPin();
      }
    });
  }

  // Method to authenticate with PIN
  Future<void> _authenticateWithPin() async {
    // Implement your PIN authentication logic here
    // For example, show a dialog to enter PIN
    // If PIN is correct, navigate to the desired screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              supportState == SupportState.supported
                  ? 'Biometric authentication is supported on this device'
                  : supportState == SupportState.unsupported
                      ? 'Biometric authentication is not supported on this device'
                      : 'Checking biometric support...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: supportState == SupportState.supported
                    ? Colors.green
                    : supportState == SupportState.unsupported
                        ? Colors.red
                        : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(authenticationMessage),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fingerprint, size: 40),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed:
                      isAuthenticating ? null : authenticateWithBiometrics,
                  child: const Text("Authenticate with fingerprint or Face ID"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
