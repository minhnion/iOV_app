import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/models/job.dart';
import 'package:iov_app/services/job_service.dart';
import 'package:iov_app/widgets/installation_search_form/installation_search_form.dart';
import 'package:iov_app/widgets/menu_tab/menu_tab.dart';
import 'package:iov_app/widgets/vehicle_card/vehicle_card.dart';

class InstallationsScreen extends StatefulWidget {
  const InstallationsScreen({super.key});

  @override
  State<InstallationsScreen> createState() => _InstallationsScreenState();
}

class _InstallationsScreenState extends State<InstallationsScreen> {

  List<Job> installations = [];
  bool isLoading = true;
  int size = 10;
  int currentPage = 1;
  late int totalRecords;
  String fromDate = '';
  String toDate = '';
  String search = '';

  List<String> savedSelectedCategories = [];

  void handleSearch(String searchKey, String from_date, String to_date, String statusKeys){
    setState(() {
      search = searchKey;
      fromDate = from_date;
      toDate = to_date;
      savedSelectedCategories = statusKeys.split(',').where((s) => s.isNotEmpty).toList();
    });
    fetchInstallations();
  }

  Future<void> fetchInstallations() async {
    try {
      setState(() {
        isLoading = true;
      });
      JobResponse jobResponse = await JobService().getJob(
        search: search,
        fromDate: fromDate,
        toDate: toDate,
        status: savedSelectedCategories,
      );
      setState(() {
        installations = jobResponse.jobs;
        totalRecords = jobResponse.totalRecords;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchInstallations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(193, 234, 193, 100),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 240, 2, 100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'iOV',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'installations'.tr(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return InstallationSearchForm(
                      onSearch: handleSearch,
                      initialImei: search,
                      initialFromDate: fromDate,
                      initialToDate: toDate,
                      initialSelectedCategories: savedSelectedCategories,
                    );
                  }
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              fetchInstallations();
            },
          ),
        ],
      ),
      drawer: MenuTab(selectedMenu: "Installations", onLanguageChanged: () {
        setState(() {

        });
      },),
      body: isLoading? const Center(child: CircularProgressIndicator(color: Colors.black,))
          : ListView(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey,
                      child: Text(installations.length.toString()),
                    )
                  ],
                ),
                ...installations.map((item) => VehicleCard(item: item)),
              ],
            ),
    );
  }

}