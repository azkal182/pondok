import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pondok/core/utils/format_currency.dart';
import 'package:pondok/injection.dart' as di;
import 'package:pondok/presentation/blocs/auth_bloc.dart';
import 'package:pondok/presentation/blocs/balance_bloc.dart';

class SidafaPage extends StatefulWidget {
  const SidafaPage({super.key});

  @override
  State<SidafaPage> createState() => _SidafaPageState();
}

class _SidafaPageState extends State<SidafaPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(GetUserData()),
        ),
        BlocProvider(
          create: (_) => di.sl<BalanceBloc>()..add(GetBalanceEvent()),
        ),
      ],
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
                        _buildInfoRow('Nama', state.user.userCredentials.nama),
                        _buildInfoRow('NIS', state.user.userCredentials.nis),
                      ],
                    );
                  }

                  return const Text("Error: Tidak dapat mengambil data.");
                },
              ),
              BlocBuilder<BalanceBloc, BalanceState>(
                builder: (context, state) {
                  String saldoTabungan = "Rp. -";
                  String saldoUpt = "Rp. -";

                  if (state is BalanceLoaded) {
                    saldoTabungan =
                        formatCurrency(state.balance.saldoTabunganInt);
                    saldoUpt = formatCurrency(state.balance.saldoUpt);
                  }

                  return Column(
                    children: [
                      _buildInfoRow('Tabungan', saldoTabungan),
                      _buildInfoRow('UPT', saldoUpt),
                    ],
                  );
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

  // Helper function to build rows with consistent spacing
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 80, // Set width for all labels to be consistent
            child: Text(
              '$label',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10), // Fixed space between label and value
          Expanded(
            child: Text(
              ': ${value}',
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis, // Ensures text does not overflow
            ),
          ),
        ],
      ),
    );
  }
}
