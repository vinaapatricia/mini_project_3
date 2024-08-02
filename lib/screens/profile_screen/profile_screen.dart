import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_3/bloc/profile_bloc/profile_bloc.dart';
import 'package:mini_project_3/model/profile_model.dart';
import 'package:mini_project_3/screens/product_screen/list_product.dart';
import 'package:mini_project_3/screens/profile_screen/components/bebas_ongkir.dart';
import 'package:mini_project_3/screens/profile_screen/components/member_silver.dart';
import 'package:mini_project_3/screens/profile_screen/components/pengaturan_akun.dart';
import 'package:mini_project_3/screens/profile_screen/components/saldo_points.dart';
import 'package:mini_project_3/screens/profile_screen/profile_detail.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffF5F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F4F4),
        title: const Text(
          'Akun Saya',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 33, 107, 35),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Akun Saya'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Keranjang'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => CartPage()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPages()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoadingState) {
                            return const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (state is ProfileErrorState) {
                            var error = state.error;
                            log(error);

                            return const Center(
                              child: Text('Ups, terjadi masalah'),
                            );
                          }

                          if (state is ProfileLoadedState) {
                            final Profile profile = state.profile;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${profile.name.firstname} ${profile.name.lastname}',
                                  style: const TextStyle(
                                    height: 1.25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  profile.phone,
                                  style: const TextStyle(height: 1.25),
                                ),
                                Text(
                                  profile.email,
                                  style: const TextStyle(height: 1.25),
                                ),
                              ],
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  ProfileDetail(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit_outlined),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    BebasOngkir(),
                    SizedBox(height: 16),
                    SaldoPoints(),
                    SizedBox(height: 16),
                    MemberSilver(),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              const PengaturanAkun(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.white,
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Color(0xff6D6D6D),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Keluar Akun',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
