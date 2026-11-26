
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color primaryColor = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About QuizByte'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const SizedBox(height: 15),

                // APP LOGO
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    size: 65,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'QuizByte',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const Text(
                  'Smart Quiz System',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 6),

                const Text('Version 1.0.0'),

                const SizedBox(height: 25),

                // ABOUT APPLICATION
                sectionCard(
                  'About the Application',
                  Icons.info_outline,
                  const Text(
                    'QuizByte is an interactive educational '
                        'mobile application designed to help users '
                        'test their knowledge, improve their skills '
                        'and analyse their quiz performance.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),

                // DEVELOPERS
                sectionCard(
                  'Developed By',
                  Icons.people_outline,
                  const Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text('Sultana Jahan Rinki'),
                        subtitle: Text('Student ID: 2212'),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text('Tasnia Yeasmin Mahi'),
                        subtitle: Text('Student ID: 2227'),
                      ),
                    ],
                  ),
                ),

                // ACADEMIC INFORMATION
                sectionCard(
                  'Academic Information',
                  Icons.school_outlined,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sylhet International University',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Department of Computer Science '
                            'and Engineering',
                      ),


                      SizedBox(height: 12),
                      Text(
                        'Course Title',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('Mobile Application Development'),
                      SizedBox(height: 12),
                      Text(
                        'Project Supervisor',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'G.M. Abdullah Al-Kafi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Lecturer, Department of CSE'),
                    ],
                  ),
                ),

                // TECHNOLOGY STACK
                sectionCard(
                  'Built With',
                  Icons.code_rounded,
                  const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          FlutterLogo(size: 38),
                          SizedBox(height: 8),
                          Text('Flutter'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.code,
                            size: 38,
                            color: primaryColor,
                          ),
                          SizedBox(height: 8),
                          Text('Dart'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.account_tree_outlined,
                            size: 38,
                          ),
                          SizedBox(height: 8),
                          Text('GitHub'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  '© 2026 QuizByte',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Developed for academic purposes.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionCard(
      String title,
      IconData icon,
      Widget content,
      ) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            content,
          ],
        ),
      ),
    );
  }
}
