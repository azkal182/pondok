import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pondok/injection.dart' as di;
import 'package:pondok/presentation/blocs/auth_bloc.dart';

class SidafaPage extends StatefulWidget {
  const SidafaPage({Key? key}) : super(key: key);

  @override
  State<SidafaPage> createState() => _SidafaPageState();
}

class _SidafaPageState extends State<SidafaPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AuthBloc>()..add(GetUserData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sidafa"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is UserLoaded) {
                    return Column(
                      children: [
                        Text(
                          'Nama, ${state.user.userCredentials.nama}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          'NIS, ${state.user.userCredentials.nis}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    );
                  }

                  return const Text("Error: Tidak dapat mengambil data.");
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(ClearAuthData());
                    },
                    child: const Text('Logout'),
                  );
                },
                listener: (context, state) {
                  if (state is AuthCleared) {
                    // Navigasi ke halaman login setelah data dihapus
                    context.go('/login');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
