import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_project_3/bloc/profile_bloc/profile_bloc.dart';
import 'package:mini_project_3/model/profile_model.dart';
import 'package:mini_project_3/services/profile_repository.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _profileImageUrl = snapshot['profileImageUrl'];
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      _uploadImage(file);
    }
  }

  Future<void> _uploadImage(File file) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        String filePath = 'images/${user.uid}.png';
        await _storage.ref(filePath).putFile(file);
        String downloadUrl = await _storage.ref(filePath).getDownloadURL();
        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': downloadUrl,
        });
        setState(() {
          _profileImageUrl = downloadUrl;
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(ProfileRepository())..add(LoadProfileEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Ubah Profil'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                : const NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Color(0xff00AA5B),
                              ),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        onPressed: _pickImage,
                        child: const Text(
                          'Ubah Foto Profil',
                          style: TextStyle(
                            color: Color(0xff00AA5B),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Info Profil',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
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
                              return const Center(
                                child: Text('Error'),
                              );
                            }

                            if (state is ProfileLoadedState) {
                              Profile profile = state.profile;

                              return infoProfil(profile);
                            }

                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alamat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
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
                              return const Center(
                                child: Text('Error'),
                              );
                            }

                            if (state is ProfileLoadedState) {
                              Profile profile = state.profile;

                              return alamat(profile);
                            }

                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Tutup Akun',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00AA5B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget alamat(Profile profile) {
    List<Map<String, dynamic>> list = [
      {
        'label': 'Geolocation',
        'title':
            '${profile.address.geoLocation.lat}, ${profile.address.geoLocation.long}',
      },
      {
        'label': 'Nomor',
        'title': profile.address.number,
      },
      {
        'label': 'Jalan',
        'title': profile.address.street,
      },
      {
        'label': 'Zip Code',
        'title': profile.address.zipCode,
      },
    ];

    return profilListTile(list);
  }

  Widget infoProfil(Profile profile) {
    List<Map<String, dynamic>> list = [
      {
        'label': 'Nama',
        'title': '${profile.name.firstname} ${profile.name.lastname}'
      },
      {
        'label': 'Nomor HP',
        'title': profile.phone,
      },
      {
        'label': 'Username',
        'title': profile.username,
      },
      {
        'label': 'E-mail',
        'title': profile.email,
      },
      {
        'label': 'Password',
        'title': '*' * profile.password.length,
      },
    ];

    return profilListTile(list);
  }

  Widget profilListTile(List<Map> list) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          leading: Text(
            list[index]['label'],
            style: const TextStyle(
              fontSize: 14,
              color: Color(
                0xff6D787A,
              ),
            ),
          ),
          title: Text(
            list[index]['title'].toString(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
        );
      },
    );
  }
}
