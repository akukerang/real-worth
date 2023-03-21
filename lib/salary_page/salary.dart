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
      appBar: AppBar(
        title: const Text('Salary Page'),
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
          return Column(
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
            ],
          );
        },
      ),
    );
  }
}
