import 'package:flutter/material.dart';
import 'JobContainer.dart';
import 'Scatter.dart';
import 'getData.dart';

class SalaryPage extends StatefulWidget {
  final String current;
  final String category;

  const SalaryPage({super.key, required this.current, required this.category});

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  String companyId = '';
  String job_name = '';
  int salary = 0;
  String years = '';

  Future<void> setValues() async {
    try {
      companyId = await getCompanyID(widget.current);
      job_name = await getJobName(widget.current);
      salary = await getSalary(widget.current);
      years = await getYears(widget.current);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text('Salary Page'),
        backgroundColor: Colors.deepPurpleAccent[400],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                setValues();
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: setValues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 25.0,
                  left: 10.0,
                  right: 10.0,
                  bottom: 10.0,
                ),
                child: getJobInfo(widget.current),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 250.0,
                  child: Scatterplot(
                    category: widget.category,
                    current: widget.current,
                    company: companyId,
                    job_name: job_name,
                  ),
                ),
              ),
              const Text(
                "Your Stats",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(24),
                  height: 120,
                  child: JobContainer(
                      position: job_name, years: years, salary: salary)),
              const Text(
                "Tips for Asking for a Raise",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Research",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "It’s important to understand the market you’re currently in based on your role within your respective field, this gives you a grasp on what is a reasonable salary amount to be asking for. Real Worth provides insight on this with our anonymous reports, demonstrating where you stand in the market.",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Evidence",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Be sure to prepare evidence as to why this raise is deserved to begin with, state your achievements within the company and the beneficial changes that have happened since you’ve arrived. This alongside your understanding of the market are both important to figuring out what exactly you want in a raise, having a clear demand whether in terms of money or benefits in mind before approaching your boss is key.",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Timing",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Be sure to pick the proper time to speak to your boss, perhaps after you’ve successfully completed a project or have been having good performance within the company. This will make your boss more willing toward your request.",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Confidence",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Be confident in your ability to secure and speak to your boss for this raise, and if it isn’t met with success the first time, don’t give up! Continue to follow up with your boss on this raise and don’t let your failures discourage you, gather feedback on what steps you can take to make your case even stronger than it already is.",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ));
        },
      ),
    );
  }
}
