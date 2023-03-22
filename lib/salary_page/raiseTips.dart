import 'package:flutter/material.dart';

class raiseTips extends StatefulWidget {
  const raiseTips({super.key});

  @override
  State<raiseTips> createState() => _raiseTipsState();
}

class _raiseTipsState extends State<raiseTips> {
  List<bool> _isExpanded = List.generate(4, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) => setState(() {
                _isExpanded[index] = !isExpanded;
              }),
          children: <ExpansionPanel>[
            ExpansionPanel(
                canTapOnHeader: true,
                body: const ListTile(
                  subtitle: Padding(
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 24),
                    child: Text(
                      "It’s important to understand the market you're in. Research what a competitive salary to be asking for that job and location is. Real Worth should provide an slight insight within the company, and how you compare with others. Feel free to use other resources, such as Salary.com",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                headerBuilder: (context, isExpanded) {
                  return const Center(
                    child: Text(
                      "Research",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                isExpanded: _isExpanded[0]),
            ExpansionPanel(
                canTapOnHeader: true,
                body: const ListTile(
                  subtitle: Padding(
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 24),
                    child: Text(
                      "Prepare evidence as to why this raise is deserved to begin with, state your achievements within the company and the beneficial changes that have happened since you've arrived. Give concrete numerical data if possible.",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                headerBuilder: (context, isExpanded) {
                  return const Center(
                    child: Text(
                      "Evidence",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                isExpanded: _isExpanded[1]),
            ExpansionPanel(
                canTapOnHeader: true,
                body: const ListTile(
                  subtitle: Padding(
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 24),
                    child: Text(
                      "Be sure to pick the proper time to speak to your boss, perhaps after you've successfully completed a project or have been having good performance within the company. This will make your boss more willing toward your request.",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                headerBuilder: (context, isExpanded) {
                  return const Center(
                    child: Text(
                      "Timing",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                isExpanded: _isExpanded[2]),
            ExpansionPanel(
                canTapOnHeader: true,
                body: const ListTile(
                  subtitle: Padding(
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 24),
                    child: Text(
                      "Be confident in your ability, and speak to your boss for this raise, and if it isn't met with success the first time, don't give up! Continue to follow up with your boss on this raise and don't let your failures discourage you, gather feedback on what steps you can take to make your case even stronger than it already is.",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                headerBuilder: (context, isExpanded) {
                  return const Center(
                    child: Text(
                      "Confidence",
                      style: TextStyle(
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                isExpanded: _isExpanded[3]),
          ]),
    );
  }
}
