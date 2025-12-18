import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

int tap = 1;
int activeUsers = 150;
int apartments = 76;
int pendingRegistration = 30;

bool viewPress = false;

String firstName = "Ahmad";
String lastName = "Nasr Alden";
String dateTime = "2025-12-16";
String phone = "0939441907";
String password = "ahmad#4321";

List pendingReg = [
  {"name": "Ahmad", "date": "2025-12-16"},
  {"name": "Ahmad", "date": "2025-12-16"},
  {"name": "Ahmad", "date": "2025-12-16"},
  {"name": "Ahmad", "date": "2025-12-16"},
  {"name": "Ahmad", "date": "2025-12-16"},
  {"name": "Ahmad", "date": "2025-12-16"},
];

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 500,
              color: Color(0xFF030341),
              child: ListView(
                children: [
                  Text(
                    "   Admin\n   Dashboard",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                    ),
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                tap = 1;
                              });
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: tap == 1
                                    ? Color(0XFFBCD4FC)
                                    : Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              height: 100,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "$activeUsers\nActive Users",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                tap = 2;
                              });
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: tap == 2
                                    ? Color(0XFFBCD4FC)
                                    : Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              height: 100,
                              child: Text(
                                "$apartments\nApartments",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                tap = 3;
                              });
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: tap == 3
                                    ? Color(0XFFBCD4FC)
                                    : Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              height: 100,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "$pendingRegistration\nPending Registration",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                tap = 4;
                              });
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: tap == 4
                                    ? Color(0XFFBCD4FC)
                                    : Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              height: 100,
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      color: Colors.white,
                      width: 400,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Name\t\t\t\t\t\t\t\t\t\t\t\t\t\tDate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                            itemCount: pendingReg.length,
                            itemBuilder: (context, i) {
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          pendingReg[i]['name'],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          pendingReg[i]['date'],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            viewPress = true;
                                          });
                                        },
                                        color: Color(0XFFBCD4FC),
                                        child: Text("View"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 200, color: Colors.white),
            if (viewPress) _buildViewPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildViewPage() {
    return Container(
      width: 500,
      color: Color(0xFF030341),
      child: ListView(
        children: [
          Text("\n", style: TextStyle(fontSize: 24, color: Colors.white)),
          GridView(
            shrinkWrap: true, // Important!
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 300,
            ),
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tap = 1;
                      });
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: tap == 1 ? Color(0XFFBCD4FC) : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      height: 100,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "$activeUsers\nActive Users",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tap = 2;
                      });
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: tap == 2 ? Color(0XFFBCD4FC) : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      height: 100,
                      child: Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tap = 3;
                      });
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: tap == 3 ? Color(0XFFBCD4FC) : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      height: 100,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "$pendingRegistration\nPending Registration",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tap = 4;
                      });
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: tap == 4 ? Color(0XFFBCD4FC) : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      height: 100,
                      child: Text(
                        "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Container(
              color: Colors.white,
              width: 400,
              height: 550,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "\nPhoto\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tPhoto ID",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0XFFBCD4FC),
                          ),
                        ),
                        Container(width: 20, height: 150, color: Colors.white),
                        Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(right: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0XFFBCD4FC),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\nFirst Name : $firstName",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "\nLast Name  : $lastName",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "\nBirth Date : $dateTime",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "\nPhone      : $phone",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "\nPassword   : $password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 30, color: Colors.white),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          color: Color(0XFF22C55E),
                          minWidth: 150,
                          child: Text(
                            "Accept",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          color: Color(0XFF8B0909),
                          minWidth: 150,
                          child: Text(
                            "Reject",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
